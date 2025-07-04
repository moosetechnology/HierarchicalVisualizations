"
A basic visualization based on the video presented by nicolas
"
Class {
	#name : 'HSimpleVisualizationBuilder',
	#superclass : 'RSAbstractContainerBuilder',
	#instVars : [
		'rootNode',
		'menuInteraction',
		'highlightable',
		'baseNode',
		'linkStyler',
		'popup',
		'mapModel'
	],
	#category : 'Hierarchical-Roassal-Visualization',
	#package : 'Hierarchical-Roassal',
	#tag : 'Visualization'
}

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> addInteractions: aGroupOfShapes [

	aGroupOfShapes do: [ :cs | self addInteractionsToShape: cs ]
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> addInteractionsToShape: aShape [

	| node |
	aShape announcer: self nodeAnnouncer.
	node := aShape model.
	node
		removeInteractionIfPresent: self class;
		when: HNodeAddedEvent
		do: [ :evt | self rebuildRootShape: aShape ]
		for: self;
		when: HCollapseEvent
		do: [ :evt | self rebuildShape: aShape ]
		for: self;
		when: HExpandEvent
		do: [ :evt | self rebuildRootShape: aShape ]
		for: self;
		when: HNodeChangedEvent
		do: [ :evt | self rebuildShape: aShape ]
		for: self;
		when: HNodeRemovedEvent
		do: [ :evt | self removeShape: aShape ]
		for: self
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> addNewNode: evt [
	| newShape canvas |
	canvas := self container.
	newShape := (self shapeFor: evt newChild) sparent: canvas.
	newShape position: canvas visibleRectangle floatCenter.
	self addInteractionsToShape: newShape.
	
	shapes add: newShape.
	canvas add: newShape.
	canvas signalUpdate
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> baseNode [
	^ baseNode
]

{ #category : 'public - hooks' }
HSimpleVisualizationBuilder >> borderFor: node [
	^ node hasChildren
		ifTrue: [ RSBorder new 
			width: 2; 
			capSquare;
			joinMiter;
			color: Smalltalk ui theme textColor;
			dashArray: #(5 10);
			yourself  ]
		ifFalse: [ nil ]
]

{ #category : 'accessing - defaults' }
HSimpleVisualizationBuilder >> canvasController: canvas [

	^ RSCanvasController new
		  noLegend;
		  in: [ :i |
			  canvas newAnimation
				  duration: 500 milliSeconds;
				  onStepDo: [ canvas signalUpdate ];
				  when: RSAnimationEndEvent
				  do: [ i zoomToFitInteraction noZoomToFitOnExtendChanged ]
				  for: self.
			  (i interactions at: RSDraggableCanvasInteraction) left.
			  i configuration
				  maxScale: 3;
				  minScale: 0.5
			  "useBasicZoom;" ];
		  yourself
]

{ #category : 'public - hooks' }
HSimpleVisualizationBuilder >> childrenFor: node [
	^ node children collect: [ :child | self shapeFor: child ] as: RSGroup
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> childrenShapes: aCanvas [

	^ rootNode children
		  collect: [ :child | (self shapeFor: child) sparent: aCanvas ]
		  as: RSGroup
]

{ #category : 'public - hooks' }
HSimpleVisualizationBuilder >> colorFor: node [
	^ Color colorFrom: (node color ifNil: [ #gray ])
]

{ #category : 'accessing - defaults' }
HSimpleVisualizationBuilder >> createBoxSelectionFor: shape [
	| border canvas |
	canvas := shape parent.
	shape removeSelectionBox.
			
	border := RSBox new
		cornerRadius: 10;
		noPaint;
		border: (RSBorder new 
			color: Smalltalk ui theme textColor;
			width: 5;
			yourself);
		yourself.
	shape selectionBox: border.
	HUpdateSelectionBox new updateSelectionBox: shape.
	canvas addShape: border.
	border pushBack.
	
]

{ #category : 'accessing - defaults' }
HSimpleVisualizationBuilder >> defaultContainer [
	| canvas |
	canvas := RSCanvas new.
	canvas @ (self canvasController: canvas).
	canvas @ (self elasticBoxFor: canvas).
	^ canvas
]

{ #category : 'accessing - defaults' }
HSimpleVisualizationBuilder >> elasticBoxFor: aRSCanvas [

	| elastic selectionHigh |
	elastic := RSElasticBoxInteraction new.
	elastic targetShapes: aRSCanvas nodes.
	selectionHigh := RSHighlightable new
		                 when: RSHighlightEvent
		                 do: [ :evt | self createBoxSelectionFor: evt shape ]
		                 for: self;
		                 when: RSUnHighlightEvent
		                 do: [ :evt | evt shape removeSelectionBox ]
		                 for: self.
	elastic
		when: RSSelectionStartEvent
		do: [ :evt | selectionHigh unhighlightRecordedShapes: evt canvas ]
		for: self;
		when: RSSelectionChangedEvent
		do: [ :evt | selectionHigh doHighlightShapes: evt selectedShapes ]
		for: self;
		when: RSSelectionEndEvent
		do: [ :evt | evt canvas selectedShapes: evt selectedShapes ]
		for: self.

	^ elastic
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> expandChildren [

	self container shapes do: #remove.
	self renderIn: self container
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> fixShadowForSelectedShape: shape and: newShape [
	| canvas selectedShapes border |
	border := shape selectionBox.
	border ifNil: [ ^ self ].
	canvas := newShape canvas.
	selectedShapes := canvas selectedShapes.
	newShape selectionBox: border.
	HUpdateSelectionBox new updateSelectionBox: newShape.
	selectedShapes at: (selectedShapes indexOf: shape) put: newShape
]

{ #category : 'accessing - attributes' }
HSimpleVisualizationBuilder >> highlightable [

	^ highlightable ifNil: [
		  highlightable := RSHighlightable new
			                   highlightShapes: [ :shape |
				                   | list |
				                   list := shape connectedLines copy.
				                   list add: (shape propertyAt: #background).
				                   list ];
			                   when: RSHighlightEvent do: [ :evt |
				                   | color |
				                   color := evt shape isNode
					                            ifTrue: [ evt shape color muchDarker ]
					                            ifFalse: [ Color red ].
				                   highlightable
					                   record: evt shape
					                   selector: #color
					                   value: color ]
			                   for: self;
			                   when: RSUnHighlightEvent
			                   do: [ :evt |
				                   highlightable
					                   restore: evt shape
					                   selector: #color ]
			                   for: self;
			                   yourself ]
]

{ #category : 'initialization' }
HSimpleVisualizationBuilder >> initialize [

	super initialize.
	self linkStyler: HLinkStyler new.
	self popup: RSPopup new
]

{ #category : 'layout' }
HSimpleVisualizationBuilder >> layoutOn: aGroupOfShapes parent: shape [
	aGroupOfShapes ifEmpty: [ ^ self ].
	
	aGroupOfShapes first model position ifNotNil: [ 
		aGroupOfShapes do: [ :child | child position: (child model position ifNil: [ 0@0 ]) ].
		^ self.
		 ].
	self relayout: aGroupOfShapes parent: shape.
	
	
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> lineBuilder [
	^ self linkStyler lineBuilder
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> linkStyler [
	^ linkStyler
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> linkStyler: anHLinkStyler [
	linkStyler :=anHLinkStyler
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> mapModel [

	^ mapModel
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> mapModel: anObject [

	mapModel := anObject
]

{ #category : 'accessing - attributes' }
HSimpleVisualizationBuilder >> menuInteraction [

	^ menuInteraction ifNil: [ 
		  menuInteraction := RSMenuActivable new
			                     menuDo: [ :menu :aShape | 
				                     HMenuBuilder new
					                     menuItemStrategy: self menuItemStrategy;
					                     buildIn: menu
					                     shape: aShape
					                     visualization: self;
					                     yourself ];
			                     yourself ]
]

{ #category : 'accessing - attributes' }
HSimpleVisualizationBuilder >> menuItemStrategy [

	^ HDefaultMenuItemStrategy new
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> nodeAnnouncer [
	"plug new events here"
	baseNode ifNotNil: [ ^ baseNode announcer ].
	baseNode := RSComposite new
		@ self popup;
		@ (HGhostDraggable new 
			color: Smalltalk ui theme caretColor);
		@ self menuInteraction;
		@ self highlightable;
		@ (RSNodeOnTopWhenPositionChanged new);
		@ (HUpdateSelectionBox new);
		@ (HResizeParentWhenChildMoves new );
		yourself.
	^ baseNode announcer
	
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> popup [

	^ popup
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> popup: anObject [

	popup := anObject
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> rebuildLines: shape [
	| canvas |
	canvas := shape canvas.
	canvas lines copy do: #remove.
	self renderLinesIn: canvas.
	canvas signalUpdate.
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> rebuildRootShape: shape [
	| rootShape |
	rootShape := self rootShapeFrom: shape.
	self rebuildShape: rootShape.
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> rebuildShape: shape [

	| canvas newShape node parent children allChildrenShapes |
	node := shape model.
	canvas := shape canvas.
	canvas ifNil: [ ^ self ].
	canvas lines copy do: #remove.
	self removeShapeWithAllChildren: shape.
	newShape := self shapeFor: node.
	newShape position: shape position.
	parent := shape parent.
	parent add: newShape.

	"shape sparent schildren add: newShape."
	children := shape sparent schildren.
	children
		remove: shape;
		add: newShape.
	newShape sparent: shape sparent.
	shape remove.
	allChildrenShapes := newShape withAllSChildren.
	shapes addAll: allChildrenShapes.
	self addInteractions: allChildrenShapes.
	self renderLinesIn: canvas.
	self fixShadowForSelectedShape: shape and: newShape.

	(canvas visibleRectangle containsRect:
		 newShape globalEncompassingRectangle) ifFalse: [ 
		canvas camera
			zoomToFit: canvas extent * 0.9
			rectangle: newShape encompassingRectangle ].

	canvas signalUpdate
]

{ #category : 'layout' }
HSimpleVisualizationBuilder >> relayout: aGroupOfShapes parent: shape [
	shape layout ifNil: [ 
		RSFlowLayout new
			gapSize: 10;
			on: aGroupOfShapes. 
		^ self ].
	shape layout on: aGroupOfShapes.
	
	
]

{ #category : 'removing' }
HSimpleVisualizationBuilder >> removeShape: aShape [ 
	
	aShape remove.
	shapes remove: aShape.
	aShape model removeInteractionIfPresent: self class.
	container signalUpdate
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> removeShapeWithAllChildren: shape [
	
	shape schildren do: [ :child | self removeShapeWithAllChildren: child. ].
	shape model removeInteractionIfPresent: self class.
	shapes remove: shape.
	
]

{ #category : 'rendering' }
HSimpleVisualizationBuilder >> renderIn: aCanvas [

	| rootShapes |
	aCanvas color: Smalltalk ui theme backgroundColor.

	rootShapes := self childrenShapes: aCanvas.
	shapes := rootShapes flatCollect: [ :s | s withAllSChildren ].
	self addInteractions: shapes.
	aCanvas schildren: rootShapes.
	aCanvas addAll: rootShapes.

	aCanvas useRTree.
	(aCanvas hasInteraction: RSMenuActivable) ifFalse: [
		aCanvas @ self menuInteraction ].
	(aCanvas hasInteraction: self) ifFalse: [  
	rootNode
		when: HNodeAddedEvent send: #addNewNode: to: self;
		when: HExpandChildrenEvent
		do: [ :evt | self expandChildren ]
		for: self] .
	self renderLinesIn: aCanvas.
	self layoutOn: rootShapes parent: rootNode
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> renderLinesIn: aCanvas [

	| announcer high |
	self lineBuilder
		canvas: aCanvas;
		shapes: shapes;
		connectFromAll: [ :n | n dependentsFromLinks ].
	announcer := Announcer new.
	high := RSHighlightable red.
	high onShape: announcer.
	self menuInteraction onShape: announcer.
	aCanvas lines do: [ :line | line announcer: announcer ]
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> rootNode [
	^ rootNode
]

{ #category : 'accessing' }
HSimpleVisualizationBuilder >> rootNode: aHNode [ 
	rootNode := aHNode
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> rootShapeFrom: shape [
	| parent |
	parent := shape sparent.
	^ parent class = RSCanvas
		ifTrue: [ shape ]
		ifFalse: [ self rootShapeFrom: parent ].
		
]

{ #category : 'hooks' }
HSimpleVisualizationBuilder >> shapeFor: node [

	^ node asShape
]

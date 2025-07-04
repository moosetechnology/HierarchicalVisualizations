"
Implementation note: The styles are computed lazilly to gain speed on visualizations that creates a huge amount of style that are not always used because most nodes are hidden.
"
Class {
	#name : 'HStyle',
	#superclass : 'Object',
	#instVars : [
		'baseLabel',
		'boxChildrenColorPalette',
		'titleLocation'
	],
	#category : 'Hierarchical-Roassal',
	#package : 'Hierarchical-Roassal'
}

{ #category : 'accessing' }
HStyle >> baseLabel [

	^ baseLabel ifNil: [
		  baseLabel := RSLabel new
			               fontSize: 12;
			               color: Smalltalk ui theme textColor;
			               fontName: 'Source Sans Pro';
			               yourself ]
]

{ #category : 'hooks' }
HStyle >> borderFor: node [
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

{ #category : 'hooks' }
HStyle >> boxChildrenColorFor: anHNode [
	^ self boxChildrenColorPalette scale: anHNode level
]

{ #category : 'accessing' }
HStyle >> boxChildrenColorPalette [

	^ boxChildrenColorPalette ifNil: [ boxChildrenColorPalette := NSScale ordinal range: Smalltalk ui theme roassalHNodeBackgroundColors ]
]

{ #category : 'accessing' }
HStyle >> boxChildrenColorPalette: anObject [

	boxChildrenColorPalette := anObject
]

{ #category : 'hooks' }
HStyle >> boxChildrenFor: anHNode [
	^ RSBox new
		color: (self boxChildrenColorFor: anHNode);
		yourself.
]

{ #category : 'hooks' }
HStyle >> buildCompositeEmptyNodeIn: shape [

	self subclassResponsibility
]

{ #category : 'hooks' }
HStyle >> buildCompositeFullNodeIn: shape [

	self subclassResponsibility
]

{ #category : 'private' }
HStyle >> colorFor: node [

	^ Color colorFrom: (node color ifNil: [ #gray ])
]

{ #category : 'hooks' }
HStyle >> labelFor: anHNode [

	^ self baseLabel copy
		  text: (self textFor: anHNode);
		  yourself
]

{ #category : 'hooks' }
HStyle >> layoutOn: aGroupOfShapes parent: anHNode [
	aGroupOfShapes ifEmpty: [ ^ self ].
	
	aGroupOfShapes first model position ifNotNil: [ 
		aGroupOfShapes do: [ :child | child position: (child model position ifNil: [ 0@0 ]) ].
		^ self.
		 ].
	self relayout: aGroupOfShapes parent: anHNode.
	
	
]

{ #category : 'hooks' }
HStyle >> relayout: aGroupOfShapes parent: anHNode [
	anHNode layout ifNil: [ 
		RSFlowLayout new
			gapSize: 10;
			on: aGroupOfShapes. 
		^ self ].
	anHNode layout on: aGroupOfShapes.
	
	
]

{ #category : 'hooks' }
HStyle >> shapeFor: aHNode [

	| shape |
	shape := RSComposite new
		         model: aHNode;
		         yourself.
	(aHNode isExpanded and: [ aHNode hasChildren ])
		ifTrue: [ self buildCompositeFullNodeIn: shape ]
		ifFalse: [ self buildCompositeEmptyNodeIn: shape ].

	^ shape
]

{ #category : 'hooks' }
HStyle >> textFor: aHNode [

	^ aHNode name
]

{ #category : 'hooks' }
HStyle >> titleLocation [

	^ titleLocation ifNil: [
		  titleLocation := RSLocation new
			                   insideCornerLeft;
			                   offset: 10 @ 0 ]
]

{ #category : 'accessing' }
HStyle >> titleLocation: anObject [

	titleLocation := anObject
]

{ #category : 'hooks' }
HStyle >> updateShape: shape with: parent [
	"use this method to update the layout distribution of one node shape
	after the children shape is updated"
]

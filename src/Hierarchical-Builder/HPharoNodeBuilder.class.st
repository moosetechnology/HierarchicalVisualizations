"
TODO
"
Class {
	#name : #HPharoNodeBuilder,
	#superclass : #HNodeBuilder,
	#instVars : [
		'packageQuery',
		'colorPalette',
		'nodeStyle'
	],
	#category : #'Hierarchical-Builder'
}

{ #category : #building }
HPharoNodeBuilder >> build [
	rootNode := HNode named: 'Root'.
	rootNode addAll: (self pharoPackages collect: [ :pkg | self buildNodeFromPackage: pkg ]).
	self createDependenciesBetweenMethods.
	self updateNode: rootNode.
	
]

{ #category : #building }
HPharoNodeBuilder >> buildNodeFromClass: clazz [
	^ HNode new
		name: clazz name;
		rawModel: clazz;
		iconName: #class;
		style: nodeStyle; 
		addAll: (clazz methods collect: [:met | self buildNodefromMethod: met ]);
		collapse;
		yourself
]

{ #category : #building }
HPharoNodeBuilder >> buildNodeFromPackage: package [ 
	^ HNode new
		name: package name;
		rawModel: package;
		iconName: #monticelloPackage;
		style: nodeStyle;
		addAll: (package definedClasses collect: [:cls | self buildNodeFromClass: cls ]);
		yourself
]

{ #category : #building }
HPharoNodeBuilder >> buildNodefromMethod: method [
	^ HNode new
		name: method selector;
		rawModel: method;
		style: nodeStyle;
		iconName: #glamorousBrowse;
		yourself
	
]

{ #category : #accessing }
HPharoNodeBuilder >> colorPalette [
	^ colorPalette
]

{ #category : #accessing }
HPharoNodeBuilder >> colorPalette: aNSOrdinalScale [
	colorPalette := aNSOrdinalScale
]

{ #category : #building }
HPharoNodeBuilder >> createDependenciesBetweenMethods [
	| methods |
	methods := rootNode children flatCollect: [ :pkg | 
		pkg children flatCollect: [ :cls | cls children ] ].
	methods copy do: [ :met | | nodes |
		nodes := met rawModel messages flatCollect: [:str | 
			methods select: [ :met1 | met1 name = str ]
			].
		met dependenciesToNodes: nodes.
	].
	
]

{ #category : #initialization }
HPharoNodeBuilder >> initialize [
	super initialize.
	self colorPalette: (NSScale category10 in: [:s | s range: {Color gray}, s range ]).
	nodeStyle := HDefaultStyle new
]

{ #category : #accessing }
HPharoNodeBuilder >> nodeStyle [

	^ nodeStyle
]

{ #category : #accessing }
HPharoNodeBuilder >> nodeStyle: anObject [

	nodeStyle := anObject
]

{ #category : #accessing }
HPharoNodeBuilder >> packageQuery [

	^ packageQuery
]

{ #category : #accessing }
HPharoNodeBuilder >> packageQuery: anObject [

	packageQuery := anObject
]

{ #category : #building }
HPharoNodeBuilder >> pharoPackages [

	^ self packageOrganizer packages select: [ :package | packageQuery match: package name ]
]

{ #category : #building }
HPharoNodeBuilder >> updateNode: node [
	node color: (self colorPalette scale: node level).
	node children do: [ :child| self updateNode: child ].
	
]

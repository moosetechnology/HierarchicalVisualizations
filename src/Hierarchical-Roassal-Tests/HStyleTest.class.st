Class {
	#name : 'HStyleTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'styleClass',
		'rootNode'
	],
	#category : 'Hierarchical-Roassal-Tests',
	#package : 'Hierarchical-Roassal-Tests'
}

{ #category : 'building suites' }
HStyleTest class >> testParameters [
	^ ParametrizedTestMatrix new
		forSelector: #styleClass
		addOptions: HStyle allSubclasses
]

{ #category : 'running' }
HStyleTest >> setUp [

	super setUp.
	rootNode := HNode named: 'ROOT'
]

{ #category : 'accessing' }
HStyleTest >> styleClass [

	^ styleClass
]

{ #category : 'accessing' }
HStyleTest >> styleClass: anObject [

	styleClass := anObject
]

{ #category : 'tests' }
HStyleTest >> testShapeForWithChildren [

	| style mockEntity mockTag |
	style := styleClass new.
	mockEntity := Mock named: 'AnEnitty'.
	mockTag := Mock named: 'ATag'.
	mockEntity stub tags willReturn: { mockTag }.
	mockTag stub color willReturn: Color red.


	1 to: 10 do: [ :i |
			rootNode add:
				((HNode named: 'number ' , i asString) rawModel: mockEntity) ].
	self assert: ((style shapeFor: rootNode) isKindOf: RSShape)
]

{ #category : 'tests' }
HStyleTest >> testShapeForWithNoChildren [

	| style |
	style := styleClass new.
	
	self assert: ((style shapeFor: rootNode) isKindOf: RSShape)
]

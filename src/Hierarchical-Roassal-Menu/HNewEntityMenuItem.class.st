"
This menu item open a new request dialog to get the name of the new node of the selected node
"
Class {
	#name : 'HNewEntityMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HNewEntityMenuItem >> execute [
	| name node |
	name := HNewContainerMenuItem requestName.
	name ifNil: [ ^ self ].
	node := shape model.
	node add: (HNode named: name; yourself).
]

{ #category : 'accessing' }
HNewEntityMenuItem >> group [
	^ 2
]

{ #category : 'accessing' }
HNewEntityMenuItem >> label [
	^ 'New entity'
]

{ #category : 'accessing' }
HNewEntityMenuItem >> order [
	^ 30
]

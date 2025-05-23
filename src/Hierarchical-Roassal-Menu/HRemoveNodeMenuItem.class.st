Class {
	#name : 'HRemoveNodeMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'accessing' }
HRemoveNodeMenuItem >> execute [

	shape model remove
]

{ #category : 'accessing' }
HRemoveNodeMenuItem >> group [
	^ 100
]

{ #category : 'accessing' }
HRemoveNodeMenuItem >> label [

	^ 'Remove node'
]

{ #category : 'accessing' }
HRemoveNodeMenuItem >> order [

	^ 1000
]

Class {
	#name : 'HRemoveMenuItem',
	#superclass : 'HGroupMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HRemoveMenuItem >> execute [

	visualization canvas selectedShapes do: [ :aShape | aShape model remove ]
]

{ #category : 'accessing' }
HRemoveMenuItem >> group [
	^ 100
]

{ #category : 'accessing' }
HRemoveMenuItem >> label [
	^ 'Remove elements'
]

{ #category : 'accessing' }
HRemoveMenuItem >> order [
	^ 100
]

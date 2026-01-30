"
menu item to remove a link from an HNode
"
Class {
	#name : 'HRemoveLineMenuItem',
	#superclass : 'HLineMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HRemoveLineMenuItem >> execute [
	shape model key removeLinkTo: shape model value.
	visualization rebuildLines: shape.
	
]

{ #category : 'accessing' }
HRemoveLineMenuItem >> label [
	^ 'Remove link'
]

{ #category : 'accessing' }
HRemoveLineMenuItem >> order [
	^ 10
]

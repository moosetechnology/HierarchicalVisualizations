"
this menu hide outgoing links
"
Class {
	#name : 'HHideOutgoingLinksMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HHideOutgoingLinksMenuItem >> execute [
	shape model hideOutgoingLinks.
	visualization rebuildLines: shape.
]

{ #category : 'accessing' }
HHideOutgoingLinksMenuItem >> group [
	^ 3
]

{ #category : 'accessing' }
HHideOutgoingLinksMenuItem >> label [
	^ 'Hide outgoing links'
]

{ #category : 'accessing' }
HHideOutgoingLinksMenuItem >> order [
	^ 62
]

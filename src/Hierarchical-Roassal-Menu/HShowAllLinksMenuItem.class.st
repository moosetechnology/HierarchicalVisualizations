"
This menu item shows all the links of the node and all children.
"
Class {
	#name : 'HShowAllLinksMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HShowAllLinksMenuItem >> execute [
	shape model showAllLinks.
	visualization rebuildLines: shape.
]

{ #category : 'accessing' }
HShowAllLinksMenuItem >> group [
	^ 3
]

{ #category : 'accessing' }
HShowAllLinksMenuItem >> label [
	^ 'Show all links'
]

{ #category : 'accessing' }
HShowAllLinksMenuItem >> order [
	^ 50
]

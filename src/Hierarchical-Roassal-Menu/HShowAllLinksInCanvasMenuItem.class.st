Class {
	#name : 'HShowAllLinksInCanvasMenuItem',
	#superclass : 'HCanvasMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HShowAllLinksInCanvasMenuItem >> execute [
	visualization rootNode showAllLinks.
	visualization rebuildLines: visualization canvas.
]

{ #category : 'accessing' }
HShowAllLinksInCanvasMenuItem >> group [
	^ 2
]

{ #category : 'accessing' }
HShowAllLinksInCanvasMenuItem >> label [
	^ 'Show all links'
]

{ #category : 'accessing' }
HShowAllLinksInCanvasMenuItem >> order [
	^ 20
]

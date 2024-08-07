"
reorganize the canvas with the layout of the root node
"
Class {
	#name : 'HRelayoutCanvasMenuItem',
	#superclass : 'HCanvasMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HRelayoutCanvasMenuItem >> execute [
	| rootNode |
	rootNode := visualization rootNode.
	rootNode children do: [ :child | child position: nil ].
	visualization layoutOn: visualization container nodes parent: rootNode.
	visualization container signalUpdate.
]

{ #category : 'accessing' }
HRelayoutCanvasMenuItem >> group [
	^ 1
]

{ #category : 'accessing' }
HRelayoutCanvasMenuItem >> label [
	^ 'Relayout'
]

{ #category : 'accessing' }
HRelayoutCanvasMenuItem >> order [
	^ 70
]

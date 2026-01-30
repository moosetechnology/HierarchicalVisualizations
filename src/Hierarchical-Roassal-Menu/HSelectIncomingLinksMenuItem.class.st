"
This menu item selects the incoming links of the node.
"
Class {
	#name : 'HSelectIncomingLinksMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HSelectIncomingLinksMenuItem >> execute [

	visualization container setSelectedShapes: shape incomingShapes
]

{ #category : 'accessing' }
HSelectIncomingLinksMenuItem >> group [

	^ 3
]

{ #category : 'accessing' }
HSelectIncomingLinksMenuItem >> label [

	^ 'Select incoming links'
]

{ #category : 'accessing' }
HSelectIncomingLinksMenuItem >> order [

	^ 110
]

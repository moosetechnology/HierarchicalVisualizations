"
This menu item selects the outgoing links of the node.
"
Class {
	#name : 'HSelectOutgoingLinksMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HSelectOutgoingLinksMenuItem >> execute [

	visualization container setSelectedShapes: shape outgoingShapes
]

{ #category : 'accessing' }
HSelectOutgoingLinksMenuItem >> group [

	^ 3
]

{ #category : 'accessing' }
HSelectOutgoingLinksMenuItem >> label [

	^ 'Select outgoing links'
]

{ #category : 'accessing' }
HSelectOutgoingLinksMenuItem >> order [

	^ 120
]

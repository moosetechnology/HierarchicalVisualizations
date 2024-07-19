"
This menu item selects all the links of the node.
"
Class {
	#name : 'HSelectAllLinksMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'execution' }
HSelectAllLinksMenuItem >> execute [

	visualization container setSelectedShapes:
		shape outgoingShapes , shape incomingShapes
]

{ #category : 'accessing' }
HSelectAllLinksMenuItem >> group [

	^ 3
]

{ #category : 'accessing' }
HSelectAllLinksMenuItem >> label [

	^ 'Select all links'
]

{ #category : 'accessing' }
HSelectAllLinksMenuItem >> order [

	^ 100
]

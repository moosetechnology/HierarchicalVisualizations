Extension { #name : #RSShape }

{ #category : #'*Hierarchical-Roassal' }
RSShape >> removeSelectionBox [
	| key |
	key := #selectionBox.
	(self hasProperty: key) ifFalse: [ ^ self ].
	self selectionBox remove.
	self removeKey: key.
]

{ #category : #'*Hierarchical-Roassal' }
RSShape >> selectionBox [
	^ self propertyAt: #selectionBox
]

{ #category : #'*Hierarchical-Roassal' }
RSShape >> selectionBox: aRSBox [
	^ self propertyAt: #selectionBox put: aRSBox
]

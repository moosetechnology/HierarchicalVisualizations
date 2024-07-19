"
Define the selection in canvas.
"
Class {
	#name : 'HSelectShapesMenuItem',
	#superclass : 'HCanvasMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'building - menus' }
HSelectShapesMenuItem >> buildOn: aMenuMorph [

	| submenu selections |
	submenu := MenuMorph new.
	selections := OrderedCollection new.
	selections
		add: 'Select all' -> #selectAll;
		add: 'Invert selection' -> #invertSelection.


	selections do: [ :assoc |
		submenu add: assoc key target: self selector: assoc value ].
	aMenuMorph add: self label subMenu: submenu
]

{ #category : 'accessing' }
HSelectShapesMenuItem >> execute [

	
]

{ #category : 'accessing' }
HSelectShapesMenuItem >> group [

	^ 1
]

{ #category : 'api - selection' }
HSelectShapesMenuItem >> invertSelection [

	visualization container selectedShapes ifEmpty: [ ^ self ].
	visualization container setSelectedShapes:
		visualization container nodes
		\ visualization container selectedShapes
]

{ #category : 'accessing' }
HSelectShapesMenuItem >> label [

	^ 'Select'
]

{ #category : 'accessing' }
HSelectShapesMenuItem >> order [
	
	^ 70
]

{ #category : 'api - selection' }
HSelectShapesMenuItem >> selectAll [

	visualization container setSelectedShapes: visualization container nodes
]

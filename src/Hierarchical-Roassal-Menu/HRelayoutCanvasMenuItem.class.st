"
reorganize the canvas with the layout of the root node
"
Class {
	#name : #HRelayoutCanvasMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal-Menu'
}

{ #category : #public }
HRelayoutCanvasMenuItem class >> definedLayouts [
	 ^ { RSGridLayout . RSFlowLayout . RSCircleLayout }.
]

{ #category : #'building - menus' }
HRelayoutCanvasMenuItem >> buildOn: aMenuMorph [
	| submenu |
	submenu := MenuMorph new.
	self class definedLayouts do: [ :layoutClass |  
		submenu
		add: layoutClass name
		target: self 
		selector: #execute:  
		argument: layoutClass.
	].
   aMenuMorph add: self label subMenu: submenu. 
	
]

{ #category : #execution }
HRelayoutCanvasMenuItem >> execute [
	| rootNode |
	rootNode := visualization rootNode.
	rootNode children do: [ :child | child position: nil ].
	visualization layoutOn: visualization container nodes parent: rootNode.
	visualization container signalUpdate.
]

{ #category : #execution }
HRelayoutCanvasMenuItem >> execute: layoutClass [
	| rootNode |
	rootNode := visualization rootNode.
	rootNode layout: layoutClass new.
	rootNode children do: [ :child | child position: nil ].
	visualization layoutOn: visualization container nodes parent: rootNode.
	visualization container signalUpdate.
]

{ #category : #accessing }
HRelayoutCanvasMenuItem >> group [
	^ 1
]

{ #category : #accessing }
HRelayoutCanvasMenuItem >> label [
	^ 'Relayout'
]

{ #category : #accessing }
HRelayoutCanvasMenuItem >> order [
	^ 70
]

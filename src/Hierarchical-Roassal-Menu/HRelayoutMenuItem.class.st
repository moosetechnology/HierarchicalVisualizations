"
This menu item uses the layout of an HNode to place roassal shapes in their positions.
"
Class {
	#name : 'HRelayoutMenuItem',
	#superclass : 'HNodeMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'accessing' }
HRelayoutMenuItem class >> definedLayouts [ 
	 ^ { RSGridLayout . RSFlowLayout . RSCircleLayout }.

]

{ #category : 'execution' }
HRelayoutMenuItem >> applyLayout: node [
	node children do: [ :child | child position: nil ].
	visualization rebuildShape: shape.
]

{ #category : 'building - menus' }
HRelayoutMenuItem >> buildOn: aMenuMorph [ 
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

{ #category : 'execution' }
HRelayoutMenuItem >> execute [
	self applyLayout: shape model.
]

{ #category : 'execution' }
HRelayoutMenuItem >> execute: layoutClass [ 
   |node|
   node := shape model.
   node layout: layoutClass new.
	self applyLayout: node.

]

{ #category : 'accessing' }
HRelayoutMenuItem >> group [
	^ 1
]

{ #category : 'accessing' }
HRelayoutMenuItem >> label [
	^ 'Relayout'
]

{ #category : 'accessing' }
HRelayoutMenuItem >> order [
	^ 70
]

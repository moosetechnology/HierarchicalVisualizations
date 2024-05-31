Class {
	#name : #HLayoutGroupMenuItem,
	#superclass : #HGroupMenuItem,
	#category : #'Hierarchical-Roassal-Menu'
}

{ #category : #accessing }
HLayoutGroupMenuItem class >> definedLayouts [ 
	 ^ { RSGridLayout . RSFlowLayout . RSCircleLayout }.
]

{ #category : #accessing }
HLayoutGroupMenuItem >> buildOn: aMenuMorph [
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

{ #category : #accessing }
HLayoutGroupMenuItem >> execute: aLayoutClass [

	| center |
	center := visualization canvas selectedShapes encompassingRectangle
		          center.

	aLayoutClass on: visualization canvas selectedShapes.

	visualization canvas selectedShapes translateTo: center
]

{ #category : #accessing }
HLayoutGroupMenuItem >> label [

	^ 'Layout'
]

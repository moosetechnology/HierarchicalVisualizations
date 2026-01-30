"
I build a roassal menu given a shape in a visualization.

Entry point is `buildIn: aMorph shape: aShape visualization: aCanvas`

Items in the menu are provided by the method `menuItemsFor:`
"
Class {
	#name : 'HMenuBuilder',
	#superclass : 'Object',
	#instVars : [
		'menuItemStrategy'
	],
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'public' }
HMenuBuilder >> buildIn: aMenuMorph shape: aRoassalShape visualization: anHSimpleVisualizationBuilder [

	| items |
	items := self groupItems: (self menuItemsFor: aRoassalShape).

	self
		buildIn: aMenuMorph
		shape: aRoassalShape
		visualization: anHSimpleVisualizationBuilder
		withItems: items
]

{ #category : 'public' }
HMenuBuilder >> buildIn: aMenuMorph shape: aRoassalShape visualization: anHSimpleVisualizationBuilder withItems: items [

	| groups |
	groups := items keys sorted collect: [ :key |
		          ((items at: key) sorted: [ :a :b | a order < b order ])
			          select: [ :item |
			          (item shape: aRoassalShape) canBeExecuted ] ].
	(groups reject: [ :group | group isEmpty ])
		do: [ :group |
			group do: [ :item |
				item
					visualization: anHSimpleVisualizationBuilder;
					buildOn: aMenuMorph ] ]
		separatedBy: [ aMenuMorph addSeparator ]
]

{ #category : 'public' }
HMenuBuilder >> groupItems: items [

	^ items groupedBy: [ :item | item group ]
]

{ #category : 'initialization' }
HMenuBuilder >> initialize [

	super initialize.
	menuItemStrategy := HDefaultMenuItemStrategy new
]

{ #category : 'accessing' }
HMenuBuilder >> menuItemStrategy [

	^ menuItemStrategy
]

{ #category : 'accessing' }
HMenuBuilder >> menuItemStrategy: anObject [

	menuItemStrategy := anObject
]

{ #category : 'public' }
HMenuBuilder >> menuItemsFor: aShape [

	^ (menuItemStrategy menuItemClassesFor: aShape) collect: #new
]

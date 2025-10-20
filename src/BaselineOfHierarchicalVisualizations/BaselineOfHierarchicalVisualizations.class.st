"
Baseline of hierarchical project https://github.com/moosetechnology/HierarchicalVisualizations
"
Class {
	#name : 'BaselineOfHierarchicalVisualizations',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfHierarchicalVisualizations',
	#package : 'BaselineOfHierarchicalVisualizations'
}

{ #category : 'baselines' }
BaselineOfHierarchicalVisualizations >> baseline: spec [

	<baseline>
	spec for: #common do: [
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : 'accessing' }
BaselineOfHierarchicalVisualizations >> customProjectAttributes [

	| projectAttributes |
	projectAttributes := OrderedCollection new.

	'BaselineOfMocketry' asPackageIfAbsent: [
		projectAttributes add: #NeedsMocketry ].

	(Smalltalk globals includesKey: #RSCanvas) ifTrue: [
		projectAttributes add: #NeedsRoassal ].

	^ projectAttributes
]

{ #category : 'baselines' }
BaselineOfHierarchicalVisualizations >> defineDependencies: spec [

	spec for: #nNeedsRoassal do: [ self roassal: spec ].
	spec for: #NeedsMocketry do: [ self mocketry: spec ]
]

{ #category : 'baselines' }
BaselineOfHierarchicalVisualizations >> defineGroups: spec [

	^ spec
		  group: 'Core'
		  with: #( 'Hierarchical-Model-Events' 'Hierarchical-Model'
			     'Hierarchical-Model-Tests' 'Hierarchical-Builder' );
		  group: 'default'
		  with:
			  #( 'Core' 'Hierarchical-Roassal' 'Hierarchical-Roassal-Menu'
			     'Hierarchical-Roassal-Tests' 'Hierarchical-Examples' )
]

{ #category : 'baselines' }
BaselineOfHierarchicalVisualizations >> definePackages: spec [

	spec
		package: 'Hierarchical-Model-Events';
		package: 'Hierarchical-Model';
		package: 'Hierarchical-Model-Tests';
		package: 'Hierarchical-Builder';
		package: 'Hierarchical-Roassal';
		package: 'Hierarchical-Roassal-Menu';
		package: 'Hierarchical-Examples';
		package: 'Hierarchical-Roassal-Tests'.

	spec for: #NeedsRoassal do: [
			spec
				package: 'Hierarchical-Roassal'
				with: [ spec requires: #( 'Roassal' ) ] ]
]

{ #category : 'baselines - dependencies' }
BaselineOfHierarchicalVisualizations >> mocketry: spec [

	spec baseline: 'Mocketry' with: [
		spec
			loads: #( 'Core' );
			repository: 'github://dionisiydk/Mocketry:v7.0.2' ]
]

{ #category : 'baselines - dependencies' }
BaselineOfHierarchicalVisualizations >> roassal: spec [

	spec
		baseline: 'Roassal'
		with: [ spec repository: 'github://pharo-graphics/Roassal:v1.04b' ].
	spec
		baseline: 'RoassalExporters'
		with: [
		spec repository: 'github://pharo-graphics/RoassalExporters:v1.01' ]
]

Extension { #name : 'HNode' }

{ #category : '*Hierarchical-Roassal' }
HNode >> open [
	^ HSimpleVisualizationBuilder new
		rootNode: self;
		build;
		in: [:b | b canvas openWithTitle: 'Hierarchical Visualization',
			(self name ifNil: [''] ifNotNil: [ '-', self name ]) ]
			
]

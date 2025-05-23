Class {
	#name : 'HNodeRemovedEvent',
	#superclass : 'HEvent',
	#instVars : [
		'removedNode'
	],
	#category : 'Hierarchical-Model-Events',
	#package : 'Hierarchical-Model-Events'
}

{ #category : 'accessing' }
HNodeRemovedEvent >> removedNode [

	^ removedNode
]

{ #category : 'accessing' }
HNodeRemovedEvent >> removedNode: anObject [

	removedNode := anObject
]

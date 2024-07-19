"
for inspector
"
Class {
	#name : 'HInspectorMenuItem',
	#superclass : 'HAbstractMenuItem',
	#category : 'Hierarchical-Roassal-Menu',
	#package : 'Hierarchical-Roassal-Menu'
}

{ #category : 'accessing' }
HInspectorMenuItem >> group [
	^ 100
]

{ #category : 'accessing' }
HInspectorMenuItem >> iconName [
	^ #smallInspectIt
]

{ #category : 'accessing' }
HInspectorMenuItem >> label [
	^ 'Inspect'
]

{ #category : 'accessing' }
HInspectorMenuItem >> order [
	^ 100
]

{ #category : 'accessing' }
HInspectorMenuItem >> selector [
	^ #inspect
]

{ #category : 'accessing' }
HInspectorMenuItem >> target [
	^ shape isShape
		ifTrue: [ shape model rawModel ]
		ifFalse: [ visualization rootNode ]
]

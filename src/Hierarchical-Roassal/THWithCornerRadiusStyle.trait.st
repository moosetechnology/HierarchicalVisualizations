"
I am a simple trait to add to styles holding a border radius to avoid creating new instances all the time.
"
Trait {
	#name : 'THWithCornerRadiusStyle',
	#instVars : [
		'cornerRadius'
	],
	#category : 'Hierarchical-Roassal',
	#package : 'Hierarchical-Roassal'
}

{ #category : 'hooks' }
THWithCornerRadiusStyle >> cornerRadius [

	^ cornerRadius ifNil: [ cornerRadius := RSCornerRadius new radius: self cornerRadiusValue ]
]

{ #category : 'accessing' }
THWithCornerRadiusStyle >> cornerRadiusValue [

	^ 7
]

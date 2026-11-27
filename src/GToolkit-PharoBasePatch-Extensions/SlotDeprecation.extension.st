Extension { #name : #SlotDeprecation }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
SlotDeprecation >> messageText [
	"Logged copies have their message text frozen and no context (see #copyForLog)"

	<gtPharoPatch: #Pharo>
	messageText ifNotNil: [ ^ messageText ].
	^ String
		streamContents: [ :str | 
			str
				nextPutAll: 'The instance variable ';
				nextPutAll: context receiver name;
				nextPutAll: ' accessed in ';
				nextPutAll: context sender homeMethod name;
				nextPutAll: ' has been deprecated. ';
				nextPutAll: self explanationString ]
]

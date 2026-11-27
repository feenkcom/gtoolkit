Extension { #name : #BackwardCompatibility }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
BackwardCompatibility >> messageText [
	"Logged copies have their message text frozen and no context (see #copyForLog)"

	<gtPharoPatch: #Pharo>
	messageText ifNotNil: [ ^ messageText ].
	^ String
		streamContents: [ :str | 
			self shouldTransform
				ifTrue: [ str nextPutAll: 'Automatic backward compatible senders rewrite: ' ].
			str
				nextPutAll: 'The method ';
				nextPutAll: self deprecatedMethodName;
				nextPutAll: ' called from ';
				nextPutAll: self sendingMethodName;
				nextPutAll: ' is kept for backward compatible concerns.';
				nextPutAll: explanationString ]
]

Extension { #name : #Deprecation }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Deprecation >> messageText [
	"Logged copies have their message text frozen and no context (see #copyForLog)"

	<gtPharoPatch: #Pharo>
	messageText ifNotNil: [ ^ messageText ].
	^ String
		streamContents: [ :str | 
			self shouldTransform
				ifTrue: [ str nextPutAll: 'Automatic deprecation caller rewrite: ' ].
			str
				nextPutAll: 'The method ';
				nextPutAll: self deprecatedMethodName;
				nextPutAll: ' called from ';
				nextPutAll: self sendingMethodName;
				nextPutAll: ' has been deprecated. ';
				nextPutAll: explanationString ]
]

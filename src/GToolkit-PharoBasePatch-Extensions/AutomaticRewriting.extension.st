Extension { #name : #AutomaticRewriting }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
AutomaticRewriting class >> addLog: anElement [
	"Log a copy that keeps the message text but no contexts (see #copyForLog)"

	<gtPharoPatch: #Pharo>
	self log add: anElement copyForLog
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
AutomaticRewriting >> copyForLog [
	"Answer a copy to keep in the deprecation log, which is mostly looked at after the deprecated
	method returned. The message text is computed now, while the contexts still know the sender.
	The copy references no contexts, signaler or condition: they would keep alive the receivers
	and temporaries of the deprecated method and of its senders, for example whole user interfaces.
	The original exception keeps its contexts, so transformations and warnings still work."

	^ self shallowCopy
		privateClearForLogWithMessageText: self messageTextForLog;
		yourself
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
AutomaticRewriting >> messageTextForLog [
	"The message text names the sender, which is not known when the deprecated method
	was called from a block that ran after its method returned"

	^ [ self messageText ]
		on: Error
		do: [ :anError | 
			anError
				return: (String
						streamContents: [ :aStream | 
							aStream
								nextPutAll: 'The method ';
								nextPutAll: ([ self deprecatedMethodName ] on: Error do: [ :e | e return: '?' ]);
								nextPutAll: ' has been deprecated. ';
								nextPutAll: (explanationString ifNil: [ '' ]) asString ]) ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
AutomaticRewriting >> privateClearForLogWithMessageText: aString [
	messageText := aString.
	context := nil.
	condition := nil.
	signaler := nil.
	signalContext := nil.
	handlerContext := nil.
	outerContext := nil
]

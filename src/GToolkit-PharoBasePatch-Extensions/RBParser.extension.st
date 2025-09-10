Extension { #name : #RBParser }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBParser class >> gtParseErrorClass [
	^ self 
		forPharo12AndNewer: [ #CodeError asClass] 
		forPharo11: [ SyntaxErrorNotification ]
]

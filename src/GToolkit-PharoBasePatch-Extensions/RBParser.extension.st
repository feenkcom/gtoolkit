Extension { #name : #RBParser }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBParser class >> gtParseErrorClass [
	^ self 
		forPharo12: [ #CodeError asClass] 
		forPharo11AndPharo10: [ SyntaxErrorNotification ]
]

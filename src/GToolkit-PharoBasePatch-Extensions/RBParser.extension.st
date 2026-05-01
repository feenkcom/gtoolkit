Extension { #name : #RBParser }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBParser class >> gtParseErrorClass [
	^ self 
		forPharo13AndNewer: [ #OCCodeError asClass] 
		forOlder: [CodeError] 
]

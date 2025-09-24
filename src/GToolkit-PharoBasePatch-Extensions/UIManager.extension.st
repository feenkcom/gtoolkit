Extension { #name : #UIManager }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
UIManager >> logError: anError [

	Smalltalk
		logError: (anError messageText
			ifNil: [ 
				"Ensure a description when logging if the messageText is nil"
				anError printString ])
		inContext: anError signalerContext
]

Extension { #name : #WorkingSession }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
WorkingSession >> id [
	^ id ifNil: [ id := UUID new ]
]

Extension { #name : #AutomaticRewriting }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
AutomaticRewriting class >> addLog: anElement [
	"Logged elements are mostly looked at after the deprecated method returned,
	when its context is dead (see #copyContextUpToSender)"

	<gtPharoPatch: #Pharo>
	anElement copyContextUpToSender.
	self log add: anElement
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
AutomaticRewriting >> copyContextUpToSender [
	"Once the deprecated method returns, its context is dead and has no sender,
	so the message text can no longer say who called it (see #sendingMethodName).
	We copy the contexts up to the sender, and not the rest of the stack, 
	as that would keep many more objects alive."

	| aSendingContext |
	aSendingContext := self contextOfSender ifNil: [ ^ self ].
	context := context copyTo: aSendingContext sender
]

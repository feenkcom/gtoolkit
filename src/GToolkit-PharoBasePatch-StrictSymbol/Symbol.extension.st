Extension { #name : #Symbol }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Symbol >> sameContentAs: aString [
	"Compare the receiver and aString."
	self == aString ifTrue: [^ true].
	self class == aString class ifTrue: [^ false].
	"Use String comparison otherwise"
	^ super sameContentAs: aString
]

Extension { #name : #NumberParser }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
NumberParser >> nextIntegerBase: aRadix ifFail: aBlock [
	<gtPharoPatch: #Pharo13>
	"Form an integer with optional sign and following digits from sourceStream."

	| isNeg value |
	failBlock := [ ^ aBlock value ].
	
	isNeg := self peekSignIsMinus.
	value := self nextUnsignedIntegerOrNilBase: aRadix.
	value ifNil: [^aBlock value].
	^isNeg
		ifTrue: [value negated]
		ifFalse: [value]
]

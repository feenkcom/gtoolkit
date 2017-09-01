private
process: anExample withArguments: aBlock
	| currentResult |
	currentResult := self newResultFor: anExample.
	"anExample hasValidDependencies" " dynamic check "
		"ifFalse: [ ^ self handleDependencyErrorFor: anExample ]."
	self 
		do: [ 
			currentResult returnValue: (self 
				primitiveProcessExample: anExample) ]
		on: anExample signalableExceptions
		do: [ :exception | currentResult expectedError: exception ].
	
	"self
		do: [ self processAfter: anExample ]
		on: anExample signalableExceptions
		do: [ :exception | currentResult expectedError: exception ]."
	anExample == self example ifTrue: [ result := currentResult ].
	anExample exceptions signaledBy: currentResult expectedError.
	^ currentResult returnValue
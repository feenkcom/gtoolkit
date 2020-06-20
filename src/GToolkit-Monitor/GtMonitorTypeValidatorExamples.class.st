Class {
	#name : #GtMonitorTypeValidatorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #methods }
GtMonitorTypeValidatorExamples >> methodWithKindOfFloatArgument: aFloat [
	<argument: #aFloat isKindOf: #Float>
	<argument: #aFloat satisfies: '[ :arg | arg isZero not ]'>
	<argument: #aFloat satisfies: '[ :arg | arg < 1 ]'>
	<argument: #aFloat satisfies: #notNil>
	<return: #Float>

	^ 2 / aFloat
]

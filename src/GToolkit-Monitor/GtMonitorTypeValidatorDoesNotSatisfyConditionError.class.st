Class {
	#name : #GtMonitorTypeValidatorDoesNotSatisfyConditionError,
	#superclass : #GtMonitorTypeValidatorError,
	#instVars : [
		'condition'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #accessing }
GtMonitorTypeValidatorDoesNotSatisfyConditionError >> condition [
	^ condition
]

{ #category : #accessing }
GtMonitorTypeValidatorDoesNotSatisfyConditionError >> condition: anObject [
	condition := anObject
]

{ #category : #printing }
GtMonitorTypeValidatorDoesNotSatisfyConditionError >> printOn: aStream [
	aStream nextPutAll: ('{1} ({2}) does not satisfy the condition ({3})'
		format: { self argumentName . self argumentObject printString . self condition })
]

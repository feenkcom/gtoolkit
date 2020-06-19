Class {
	#name : #GtMonitorTypeValidatorClassTypeDoesNotExistError,
	#superclass : #GtMonitorTypeValidatorError,
	#instVars : [
		'argumentClassName'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #accessing }
GtMonitorTypeValidatorClassTypeDoesNotExistError >> argumentClassName [
	^ argumentClassName
]

{ #category : #accessing }
GtMonitorTypeValidatorClassTypeDoesNotExistError >> argumentClassName: anObject [
	argumentClassName := anObject
]

{ #category : #printing }
GtMonitorTypeValidatorClassTypeDoesNotExistError >> printOn: aStream [
	aStream nextPutAll: ('Declared argument ({1}) class ({2}) does not exist' format: { self argumentName . self argumentClassName })
]

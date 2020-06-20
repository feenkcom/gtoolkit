Class {
	#name : #GtMonitorTypeValidatorError,
	#superclass : #GtMonitorTypeValidatorResult,
	#instVars : [
		'argumentName',
		'argumentObject',
		'pragma',
		'method'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #accessing }
GtMonitorTypeValidatorError >> argumentName [
	^ argumentName
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> argumentName: anObject [
	argumentName := anObject
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> argumentObject [
	^ argumentObject
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> argumentObject: anObject [
	argumentObject := anObject
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> method [
	^ method
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> method: anObject [
	method := anObject
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> pragma [
	^ pragma
]

{ #category : #accessing }
GtMonitorTypeValidatorError >> pragma: anObject [
	pragma := anObject
]

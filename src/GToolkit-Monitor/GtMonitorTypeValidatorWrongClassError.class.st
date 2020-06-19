Class {
	#name : #GtMonitorTypeValidatorWrongClassError,
	#superclass : #GtMonitorTypeValidatorError,
	#instVars : [
		'expectedClassName',
		'actualClassName'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #accessing }
GtMonitorTypeValidatorWrongClassError >> actualClassName [
	^ actualClassName
]

{ #category : #accessing }
GtMonitorTypeValidatorWrongClassError >> actualClassName: anObject [
	actualClassName := anObject
]

{ #category : #accessing }
GtMonitorTypeValidatorWrongClassError >> expectedClassName [
	^ expectedClassName
]

{ #category : #accessing }
GtMonitorTypeValidatorWrongClassError >> expectedClassName: anObject [
	expectedClassName := anObject
]

{ #category : #printing }
GtMonitorTypeValidatorWrongClassError >> printOn: aStream [
	aStream nextPutAll: ('Argument''s ({1}) class ({2}) does not correspond to the declared ({3})'
		format: { self argumentName . self actualClassName . self expectedClassName })
]

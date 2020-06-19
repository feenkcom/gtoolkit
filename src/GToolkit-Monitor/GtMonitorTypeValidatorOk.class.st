Class {
	#name : #GtMonitorTypeValidatorOk,
	#superclass : #GtMonitorTypeValidatorResult,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #accessing }
GtMonitorTypeValidatorOk class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
GtMonitorTypeValidatorOk >> isOk [
	^ true
]

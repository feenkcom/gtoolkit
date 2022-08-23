Class {
	#name : #GtPharoUserMessageSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'message'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #emitting }
GtPharoUserMessageSignal class >> emit: aString [
	^ self new
		message: aString;
		emit
]

{ #category : #accessing }
GtPharoUserMessageSignal >> message [

	^ message
]

{ #category : #accessing }
GtPharoUserMessageSignal >> message: anObject [

	message := anObject
]

{ #category : #accessing }
GtPharoUserMessageSignal >> printOneLineContentsOn: aStream [
	self message ifNil: [ ^ self ].
	aStream nextPutAll: self message asString
]

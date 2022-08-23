Class {
	#name : #GtPharoNewCodersStreamSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #printing }
GtPharoNewCodersStreamSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream
]

{ #category : #accessing }
GtPharoNewCodersStreamSignal >> stream [
	^ stream
]

{ #category : #accessing }
GtPharoNewCodersStreamSignal >> stream: anObject [
	stream := anObject
]

Class {
	#name : #GtPharoCodersStreamChangedSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'announcement'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtPharoCodersStreamChangedSignal >> announcement [

	^ announcement
]

{ #category : #accessing }
GtPharoCodersStreamChangedSignal >> announcement: anObject [

	announcement := anObject
]

{ #category : #printing }
GtPharoCodersStreamChangedSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream
]

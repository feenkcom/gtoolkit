Class {
	#name : #GtPharoSubscribedToMethodCoderSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'methodCoder'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtPharoSubscribedToMethodCoderSignal >> methodCoder [

	^ methodCoder
]

{ #category : #accessing }
GtPharoSubscribedToMethodCoderSignal >> methodCoder: anObject [

	methodCoder := anObject
]

{ #category : #printing }
GtPharoSubscribedToMethodCoderSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream.

	self methodCoder ifNil: [ ^ self ].
	self mediator ifNotNil: [ aStream nextPutAll: ', ' ].

	self methodCoder selector
		ifNotNil: [ :aSelector | aStream nextPutAll: aSelector asString ]
]

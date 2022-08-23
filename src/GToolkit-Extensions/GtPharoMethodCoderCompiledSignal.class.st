Class {
	#name : #GtPharoMethodCoderCompiledSignal,
	#superclass : #GtPharoMethodCoderAnnouncementSignal,
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtPharoMethodCoderCompiledSignal >> methodCoder [
	^ self announcement ifNotNil: #methodCoder
]

{ #category : #accessing }
GtPharoMethodCoderCompiledSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream.

	self methodCoder ifNil: [ ^ self ].
	self mediator ifNotNil: [ aStream nextPutAll: ', ' ].

	self methodCoder selector
		ifNotNil: [ :aSelector | aStream nextPutAll: aSelector asString ]
]

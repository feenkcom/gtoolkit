Class {
	#name : #GtPharoMethodCoderRemovedSignal,
	#superclass : #GtPharoMethodCoderAnnouncementSignal,
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtPharoMethodCoderRemovedSignal >> methodCoder [
	^ self announcement ifNotNil: #coder
]

{ #category : #accessing }
GtPharoMethodCoderRemovedSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream.

	self methodCoder ifNil: [ ^ self ].
	self mediator ifNotNil: [ aStream nextPutAll: ', ' ].

	self methodCoder selector
		ifNotNil: [ :aSelector | aStream nextPutAll: aSelector asString ]
]

Class {
	#name : #GtPharoMethodCoderModifiedSignal,
	#superclass : #GtPharoMethodCoderAnnouncementSignal,
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtPharoMethodCoderModifiedSignal >> methodCoder [
	^ self announcement ifNotNil: #coder
]

{ #category : #accessing }
GtPharoMethodCoderModifiedSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream.

	self methodCoder ifNil: [ ^ self ].
	self mediator ifNotNil: [ aStream nextPutAll: ', ' ].

	self methodCoder selector
		ifNotNil: [ :aSelector | aStream nextPutAll: aSelector asString ]
]

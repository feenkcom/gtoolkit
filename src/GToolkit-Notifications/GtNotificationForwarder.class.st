Class {
	#name : #GtNotificationForwarder,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - notification' }
GtNotificationForwarder class >> showNotification: aNotification [
	self default showNotification: aNotification
]

{ #category : #'api - space' }
GtNotificationForwarder class >> spaceDo: aBlock [
	self default spaceDo: aBlock
]

{ #category : #'api - space' }
GtNotificationForwarder >> anotherSpaceDo: aBlock [
	"Find a focused space"
	self focusedSpaceDo: [ :aSpace | aBlock cull: aSpace ].

	"There is no a focused space, find any opened space"
	self openedSpaceDo: [ :aSpace | aBlock cull: aSpace ]
]

{ #category : #'api - space' }
GtNotificationForwarder >> focusedSpaceDo: aBlock [
	"Find a focused space"
	BlSpace allSubInstancesDo: [ :aSpace | 
		(aSpace isOpened and: [ 
			aSpace isFocused ]) 
				ifTrue: [ ^ aBlock cull: aSpace ] ].
]

{ #category : #'api - space' }
GtNotificationForwarder >> openedSpaceDo: aBlock [
	"Find any opened space"
	BlSpace allSubInstancesDo: [ :aSpace | 
		aSpace isOpened ifTrue: [ ^ aBlock cull: aSpace ] ].
]

{ #category : #'api - notification' }
GtNotificationForwarder >> showNotification: aNotification [
	self spaceDo: [ :aSpace | 
		aSpace showNotification: aNotification ]
]

{ #category : #'api - space' }
GtNotificationForwarder >> spaceDo: aBlock [
	GtCoderExecutionContextVariable
		spaceDo: [ :aSpace | 
			aBlock cull: aSpace ]
		ifClosed: [ self anotherSpaceDo: aBlock ].
]

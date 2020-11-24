Class {
	#name : #GtNotificationForwarder,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - notification' }
GtNotificationForwarder class >> removeNotification: aNotification [
	self default removeNotification: aNotification
]

{ #category : #'api - notification' }
GtNotificationForwarder class >> showNotification: aNotification [
	self default showNotification: aNotification
]

{ #category : #'api - notification' }
GtNotificationForwarder >> removeNotification: aNotification [
	aNotification requestRemoval
]

{ #category : #'private - notification' }
GtNotificationForwarder >> showInFocusedSpace: aNotification [
	"Such a space is closed, display it in a focused space".
	BlSpace allSubInstancesDo: [ :aSpace | 
		aSpace isFocused ifTrue: [ ^ aSpace showNotification: aNotification ] ].

	"There is no a focused space, display it in any space"
	BlSpace allSubInstancesDo: [ :aSpace | 
		aSpace isOpened ifTrue: [ ^ aSpace showNotification: aNotification ] ].

]

{ #category : #'api - notification' }
GtNotificationForwarder >> showNotification: aNotification [
	GtCoderExecutionContextVariable
		spaceDo: [ :aSpace | 
			aSpace showNotification: aNotification ]
		ifClosed: [ self showInFocusedSpace: aNotification ].
]

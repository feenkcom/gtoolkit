"
I model a notification.
"
Class {
	#name : #GtNotification,
	#superclass : #Object,
	#instVars : [
		'id',
		'status',
		'cardStencil',
		'openAction',
		'refreshAction',
		'closeAction'
	],
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotification >> cardStencil [
	^ cardStencil
]

{ #category : #accessing }
GtNotification >> cardStencil: aCardStencil [
	cardStencil := aCardStencil.
	cardStencil 
		openAction: [ :newsElement|
			self executeOpenFor: newsElement ];
		closeAction: [ :newsElement |
			self executeCloseFor: newsElement]
]

{ #category : #actions }
GtNotification >> executeCloseFor: anElement [
	self markAsDismissedAndSaveStatus.
	refreshAction value.
]

{ #category : #actions }
GtNotification >> executeOpenFor: anElement [
	openAction cull: anElement.
	self markAsViewsAndSaveStatus.
	refreshAction value.
]

{ #category : #accessing }
GtNotification >> id [
	^ id
]

{ #category : #accessing }
GtNotification >> id: anId [
	id := anId
]

{ #category : #accessing }
GtNotification >> markAsDismissedAndSaveStatus [
	self status: GtNotificationDismissedStatus new.
	self statusRegistry 
		updateStatusForNotification: self;
		saveContent.
]

{ #category : #actions }
GtNotification >> markAsViewsAndSaveStatus [
	self status: GtNotificationViewedStatus new.
	self statusRegistry 
		updateStatusForNotification: self;
		saveContent.
]

{ #category : #accessing }
GtNotification >> openAction: aBlock [
	openAction := aBlock
]

{ #category : #accessing }
GtNotification >> refreshAction: aBlock [
	refreshAction := aBlock
]

{ #category : #accessing }
GtNotification >> status [
	^ status
]

{ #category : #accessing }
GtNotification >> status: aStatus [
	status := aStatus
]

{ #category : #accessing }
GtNotification >> statusRegistry [
	^ GtNotificationStatusRegistry loadDefault
]

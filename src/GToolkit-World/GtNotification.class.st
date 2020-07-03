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
		'refreshAction'
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
	cardStencil action: [ :newsElement|
		self executeOpenFor: newsElement ]
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

{ #category : #actions }
GtNotification >> markAsViewsAndSaveStatus [
	self status: GtNotificationViewedStatus new.
	self statusRegistry 
		markNewsViewedForId: self id;
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

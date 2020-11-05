Class {
	#name : #GtNotificationEvent,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-Notifications'
}

{ #category : #'api - notification' }
GtNotificationEvent >> addedTo: aGtNotifications [
	"Notifications may react"
]

{ #category : #'api - converting' }
GtNotificationEvent >> asElement [
	^ GtNotificationDecoratingEventElement new
		element: self elementClass new;
		event: self
]

{ #category : #'api - accessing' }
GtNotificationEvent >> elementClass [
	"Return a class that when instantiated displayes the notification to user (as a widget)"
	<return: #GtNotificationEventElement>
	^ GtNotificationMessageElement
]

{ #category : #'gt-extension' }
GtNotificationEvent >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: self
]

{ #category : #'api - accessing' }
GtNotificationEvent >> message [
	<return: #String>
	^ self printString
]

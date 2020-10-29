Class {
	#name : #GtNotificationEvent,
	#superclass : #BlEvent,
	#category : #'GToolkit-Notifications-Events'
}

{ #category : #'api - converting' }
GtNotificationEvent >> asElement [
	^ self elementClass
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

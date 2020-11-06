Class {
	#name : #GtNotificationAbstractJobElement,
	#superclass : #GtNotificationEventElement,
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - accessing' }
GtNotificationAbstractJobElement >> jobDo: aBlock [
	self notificationDo: [ :anEvent | anEvent job ifNotNil: aBlock ]
]

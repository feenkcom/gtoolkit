Class {
	#name : #GtNotificationAbstractJobElement,
	#superclass : #GtNotificationEventElement,
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'private - accessing' }
GtNotificationAbstractJobElement >> jobDo: aBlock [
	self notificationDo: [ :anEvent | anEvent job ifNotNil: aBlock ]
]

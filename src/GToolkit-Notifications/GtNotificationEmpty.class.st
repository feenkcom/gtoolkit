Class {
	#name : #GtNotificationEmpty,
	#superclass : #GtNotificationEvent,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - accessing' }
GtNotificationEmpty >> elementClass [
	^ GtNotificationEmptyElement
]

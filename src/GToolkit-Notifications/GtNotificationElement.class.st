Class {
	#name : #GtNotificationElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #initialization }
GtNotificationElement >> initialize [
	super initialize.
	
	self matchParent
]

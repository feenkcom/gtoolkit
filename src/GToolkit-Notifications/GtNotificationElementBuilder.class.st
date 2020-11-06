Class {
	#name : #GtNotificationElementBuilder,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Notifications-UI Support'
}

{ #category : #'api - instance creation' }
GtNotificationElementBuilder class >> element: anElement [
	^ self new element: anElement
]

{ #category : #'api - building' }
GtNotificationElementBuilder >> build [
	self subclassResponsibility
]

{ #category : #'api - accessing' }
GtNotificationElementBuilder >> element [
	^ element
]

{ #category : #'api - accessing' }
GtNotificationElementBuilder >> element: anElement [
	element := anElement
]

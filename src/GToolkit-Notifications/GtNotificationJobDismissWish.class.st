Class {
	#name : #GtNotificationJobDismissWish,
	#superclass : #GtNotificationDismissWish,
	#category : #'GToolkit-Notifications-Events'
}

{ #category : #'api - accessing' }
GtNotificationJobDismissWish >> job [
	<return: #Job>
	^ self notification job
]

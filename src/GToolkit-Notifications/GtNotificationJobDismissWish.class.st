Class {
	#name : #GtNotificationJobDismissWish,
	#superclass : #GtNotificationDismissWish,
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'api - accessing' }
GtNotificationJobDismissWish >> job [
	<return: #Job>
	^ self notification job
]

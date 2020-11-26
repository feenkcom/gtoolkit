Class {
	#name : #GtNotificationBadgePublisher,
	#superclass : #BlBlocUINotificationPublisher,
	#category : #'GToolkit-Notifications-System Configuration'
}

{ #category : #'api - accessing' }
GtNotificationBadgePublisher class >> priority [
	<return: #Number>
	"Higher number, higher priority"
	^ 10
]

{ #category : #'private - displaying' }
GtNotificationBadgePublisher >> addNotification [
	| aBadge |
	aBadge := self ensureBadge.
	aBadge notification: self notification.
]

{ #category : #'private - displaying' }
GtNotificationBadgePublisher >> ensureBadge [
	| aBadge |
	aBadge := self findBadge.
	aBadge ifNil: [ 
		aBadge := self newBadge.
		self space addChild: aBadge ].
	^ aBadge
]

{ #category : #'private - displaying' }
GtNotificationBadgePublisher >> findBadge [
	self space root childrenDo: [ :aChild | 
		(aChild isKindOf: GtNotificationsBadgeElement)
			ifTrue: [ ^ aChild ] ].
	^ nil
]

{ #category : #'private - instance creation' }
GtNotificationBadgePublisher >> newBadge [
	^ GtNotificationsBadgeElement new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignTop ]
]

{ #category : #'api - displaying' }
GtNotificationBadgePublisher >> show [
	self enqueueTaskAction: [ 
		self addNotification ] 
]

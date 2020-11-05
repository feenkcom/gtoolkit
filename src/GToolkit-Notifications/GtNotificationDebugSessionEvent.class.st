Class {
	#name : #GtNotificationDebugSessionEvent,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'debugSession'
	],
	#category : #'GToolkit-Notifications-Notifications'
}

{ #category : #'api - notification' }
GtNotificationDebugSessionEvent >> addedTo: aGtNotifications [
	| aSubscription |
	aSubscription := self debugSession
		when: GtSharedDebugSessionAnnouncement
		do: [ :anAnnouncement | 
			self removeFrom: aGtNotifications.
			self debugSession removeSubscription: aSubscription ]
]

{ #category : #'private - asserting' }
GtNotificationDebugSessionEvent >> assertDebugSession: aDebugSession [
	self 
		assert: [ aDebugSession isNotNil ] 
		description: [ 'Debug session must be non-nil' ].
	self 
		assert: [ aDebugSession isKindOf: GtSharedDebugSession ] 
		description: [ 'Debug session must be a ',
			GtSharedDebugSession name, ' instance, instead of a ', 
			aDebugSession class name, ' instance'  ]
]

{ #category : #accessing }
GtNotificationDebugSessionEvent >> debugSession [
	<return: #GtSharedDebugSession>
	^ debugSession
]

{ #category : #accessing }
GtNotificationDebugSessionEvent >> debugSession: aDebugSession [
	self assertDebugSession: aDebugSession.
	debugSession := aDebugSession
]

{ #category : #'api - accessing' }
GtNotificationDebugSessionEvent >> elementClass [
	^ GtNotificationDebugSessionElement
]

{ #category : #'private - adding / removing' }
GtNotificationDebugSessionEvent >> removeFrom: aGtNotifications [
	aGtNotifications removeNotification: self
]

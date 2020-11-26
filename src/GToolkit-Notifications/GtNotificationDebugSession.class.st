Class {
	#name : #GtNotificationDebugSession,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'debugSession'
	],
	#category : #'GToolkit-Notifications-DebugSession'
}

{ #category : #'api - notification' }
GtNotificationDebugSession >> addedTo: aGtNotifications [
	| aSubscription |
	aSubscription := self debugSession
		when: GtSharedDebugSessionAnnouncement
		do: [ :anAnnouncement | 
			self removeFrom: aGtNotifications.
			self debugSession removeSubscription: aSubscription ]
]

{ #category : #'private - asserting' }
GtNotificationDebugSession >> assertDebugSession: aDebugSession [
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
GtNotificationDebugSession >> debugSession [
	<return: #GtSharedDebugSession>
	^ debugSession
]

{ #category : #accessing }
GtNotificationDebugSession >> debugSession: aDebugSession [
	self assertDebugSession: aDebugSession.
	debugSession := aDebugSession
]

{ #category : #'api - accessing' }
GtNotificationDebugSession >> elementClass [
	^ GtNotificationDebugSessionElement
]

{ #category : #'private - adding / removing' }
GtNotificationDebugSession >> removeFrom: aGtNotifications [
	aGtNotifications removeNotification: self
]

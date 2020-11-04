Class {
	#name : #GtNotificationDebugSessionEvent,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'debugSession'
	],
	#category : #'GToolkit-Notifications-Notifications'
}

{ #category : #accessing }
GtNotificationDebugSessionEvent >> debugSession [
	<return: #DebugSession>
	^ debugSession
]

{ #category : #accessing }
GtNotificationDebugSessionEvent >> debugSession: aDebugSession [
	debugSession := aDebugSession
]

{ #category : #'api - accessing' }
GtNotificationDebugSessionEvent >> elementClass [
	^ GtNotificationDebugSessionElement
]

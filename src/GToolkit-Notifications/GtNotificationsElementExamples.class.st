Class {
	#name : #GtNotificationsElementExamples,
	#superclass : #GtNotificationCommonExamples,
	#instVars : [
		'debugSessionExamples'
	],
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> debugSessionExamples [
	<gtExample>
	^ debugSessionExamples ifNil: [ debugSessionExamples := GtNotificationDebugSessionExamples new ].
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> debugSessionNotification [
	<gtExample>
	^ self debugSessionExamples debugSessionNotification
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationJob [
	<gtExample>
	^ GtNotificationJobExamples new notificationJob
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationJobWithChild [
	<gtExample>
	^ GtNotificationJobExamples new notificationJobWithChild
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationJobWithTwoChildren [
	<gtExample>
	^ GtNotificationJobExamples new notificationJobWithTwoChildren
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationMessage [
	<gtExample>
	^ GtNotificationMessageExamples new notificationMessage
]

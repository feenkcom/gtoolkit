Class {
	#name : #GtMonitoredService,
	#superclass : #Object,
	#instVars : [
		'service'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #testing }
GtMonitoredService >> exists [
	"TaskIt srevice can be garbage collected"
	<return: #Boolean>
	^ self service isNotNil
]

{ #category : #testing }
GtMonitoredService >> isRunning [
	<return: #Boolean>
	^ self service ifNotNil: #isRunning ifNil: false
]

{ #category : #accessing }
GtMonitoredService >> service [
	<return: #TKTService or: nil>

	^ service at: 1
]

{ #category : #accessing }
GtMonitoredService >> service: aService [
	service := aService asWeakReference
]

{ #category : #accessing }
GtMonitoredService >> title [
	<return: #String>
	^ self subclassResponsibility
]

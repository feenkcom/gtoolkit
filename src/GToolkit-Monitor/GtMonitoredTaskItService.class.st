Class {
	#name : #GtMonitoredTaskItService,
	#superclass : #Object,
	#instVars : [
		'service'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #testing }
GtMonitoredTaskItService >> exists [
	"TaskIt srevice can be garbage collected"
	<return: #Boolean>
	^ self service isNotNil
]

{ #category : #testing }
GtMonitoredTaskItService >> isRunning [
	<return: #Boolean>
	^ self service ifNotNil: #isRunning ifNil: false
]

{ #category : #accessing }
GtMonitoredTaskItService >> service [
	<return: #TKTService or: nil>

	^ service at: 1
]

{ #category : #accessing }
GtMonitoredTaskItService >> service: aService [
	service := aService asWeakReference
]

{ #category : #accessing }
GtMonitoredTaskItService >> title [
	<return: #String>
	^ self service name ifNil: [ '' ] ifNotNil: #trimmed
]

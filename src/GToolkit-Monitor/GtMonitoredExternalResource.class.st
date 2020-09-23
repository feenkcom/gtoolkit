Class {
	#name : #GtMonitoredExternalResource,
	#superclass : #Object,
	#instVars : [
		'resource'
	],
	#category : #'GToolkit-Monitor-External Resources'
}

{ #category : #accessing }
GtMonitoredExternalResource >> children [
	^ #()
]

{ #category : #testing }
GtMonitoredExternalResource >> isNull [
	^ resource isNull
]

{ #category : #accessing }
GtMonitoredExternalResource >> name [
	^ self resource printString
]

{ #category : #testing }
GtMonitoredExternalResource >> resource [
	^ resource
]

{ #category : #accessing }
GtMonitoredExternalResource >> resource: anObject [
	resource := anObject
]

{ #category : #testing }
GtMonitoredExternalResource >> resourceClass [
	^ resource class
]

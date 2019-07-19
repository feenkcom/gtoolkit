Class {
	#name : #GtMonitoredServiceElement,
	#superclass : #BlElement,
	#instVars : [
		'service'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #accessing }
GtMonitoredServiceElement >> service [
	^ service
]

{ #category : #accessing }
GtMonitoredServiceElement >> service: aGtMonitoredProcess [
	service := aGtMonitoredProcess.

]

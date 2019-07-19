Class {
	#name : #GtMonitoredTaskItService,
	#superclass : #GtMonitoredService,
	#category : #'GToolkit-Monitor'
}

{ #category : #accessing }
GtMonitoredTaskItService >> title [
	<return: #String>
	^ self service name ifNil: [ '' ] ifNotNil: #trimmed
]

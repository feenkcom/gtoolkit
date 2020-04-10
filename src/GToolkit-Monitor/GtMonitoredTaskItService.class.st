Class {
	#name : #GtMonitoredTaskItService,
	#superclass : #GtMonitoredService,
	#category : #'GToolkit-Monitor'
}

{ #category : #accessing }
GtMonitoredTaskItService >> numberOfFailedTasks [
	<return: #Integer>
	^ self service ifNil: 0 ifNotNil: [ :aService | aService numberOfFailedTasks ]
]

{ #category : #accessing }
GtMonitoredTaskItService >> queueSize [
	<return: #Integer>
	^ self service ifNil: 0 ifNotNil: [ :aService | aService taskQueueSize ]
]

{ #category : #accessing }
GtMonitoredTaskItService >> title [
	<return: #String>
	^ self service name ifNil: [ '' ] ifNotNil: #trimmed
]

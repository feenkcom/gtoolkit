Class {
	#name : #GtMonitoredTaskItService,
	#superclass : #GtMonitoredService,
	#category : #'GToolkit-Monitor'
}

{ #category : #'gt - extensions' }
GtMonitoredTaskItService >> gtQueueFor: aView [

	<gtView>
	self service ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Queue';
		  priority: 1;
		  object: [ self service ];
		  view: #gtQueueFor:
]

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
	| aService |
	aService := self service.

	aService ifNil: [ ^ '' ].
	^ aService name ifNil: [ '' ] ifNotNil: #trimmed
]

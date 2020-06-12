Class {
	#name : #GtMonitoredSignalLogger,
	#superclass : #Object,
	#instVars : [
		'logger'
	],
	#category : #'GToolkit-Monitor-Beacon Loggers'
}

{ #category : #testing }
GtMonitoredSignalLogger >> exists [
	^ self logger isNotNil
]

{ #category : #'gt-extension' }
GtMonitoredSignalLogger >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #testing }
GtMonitoredSignalLogger >> isDead [
	^ self isRunning not
]

{ #category : #testing }
GtMonitoredSignalLogger >> isRunning [
	^ self logger
		ifNil: [ false ]
		ifNotNil: [ :aLogger | aLogger isRunning ]
]

{ #category : #accessing }
GtMonitoredSignalLogger >> logger [
	<return: #SignalLogger or: nil>

	^ logger at: 1
]

{ #category : #accessing }
GtMonitoredSignalLogger >> logger: aSignalLogger [
	logger := aSignalLogger asWeakReference
]

{ #category : #accessing }
GtMonitoredSignalLogger >> pointers [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ self logger pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ] ]
		ifFalse: [ {  } ]
]

{ #category : #accessing }
GtMonitoredSignalLogger >> title [
	^ self logger
		ifNil: [ 'nil' ]
		ifNotNil: [ :aLogger | aLogger class name, ' (', aLogger name, ')' ]
]

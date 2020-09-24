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

{ #category : #'gt-extension' }
GtMonitoredExternalResource >> gtPathToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Path';
		priority: 102;
		items: [ self pathTo ];
		column: 'Path from Smalltalk' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredExternalResource >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		priority: 101;
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #testing }
GtMonitoredExternalResource >> isNull [
	^ (resource at: 1)
		ifNil: [ true ]
		ifNotNil: #isNull
]

{ #category : #accessing }
GtMonitoredExternalResource >> name [
	^ self resource printString
]

{ #category : #accessing }
GtMonitoredExternalResource >> pathTo [
	Smalltalk garbageCollectMost.

	^ self resource
		ifNotNil: [ :aReference | ReferenceFinder findPathTo: aReference  ]
		ifNil: [ {  } ]
]

{ #category : #accessing }
GtMonitoredExternalResource >> pointers [
	Smalltalk garbageCollectMost.

	^ self resource pointersTo
]

{ #category : #initialization }
GtMonitoredExternalResource >> reset [
	resource := nil
]

{ #category : #testing }
GtMonitoredExternalResource >> resource [
	^ resource at: 1
]

{ #category : #accessing }
GtMonitoredExternalResource >> resource: anObject [
	resource := anObject asWeakReference
]

{ #category : #testing }
GtMonitoredExternalResource >> resourceClass [
	^ self resource class
]

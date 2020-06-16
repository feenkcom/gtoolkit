Class {
	#name : #GtMonitoredBlocSpace,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Monitor-Bloc Spaces'
}

{ #category : #testing }
GtMonitoredBlocSpace >> exists [
	^ self space isNotNil
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtPathToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Path';
		priority: 11;
		items: [ self pathTo ];
		column: 'Path from Smalltalk' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		priority: 10;
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> gtPreviewFor: aView [
	<gtView>
	self space ifNil: [ ^ aView empty ].
	^ self space gtPreviewFor: aView
]

{ #category : #testing }
GtMonitoredBlocSpace >> isDead [
	^ self isRunning not
]

{ #category : #testing }
GtMonitoredBlocSpace >> isRunning [
	^ self space isOpened
]

{ #category : #accessing }
GtMonitoredBlocSpace >> pathTo [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ ReferenceFinder findPathTo: self space ]
		ifFalse: [ {  } ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> pointers [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ self space pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ] ]
		ifFalse: [ {  } ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> references [
]

{ #category : #accessing }
GtMonitoredBlocSpace >> space [
	<return: #BlSpace or: nil>

	^ space at: 1
]

{ #category : #accessing }
GtMonitoredBlocSpace >> space: aSpace [
	space := aSpace asWeakReference
]

{ #category : #accessing }
GtMonitoredBlocSpace >> title [
	^ self space title
]

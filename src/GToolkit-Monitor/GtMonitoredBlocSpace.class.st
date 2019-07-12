Class {
	#name : #GtMonitoredBlocSpace,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #testing }
GtMonitoredBlocSpace >> exists [
	^ self space isNotNil
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
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

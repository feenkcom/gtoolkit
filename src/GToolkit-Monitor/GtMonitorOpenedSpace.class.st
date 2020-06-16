Class {
	#name : #GtMonitorOpenedSpace,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Monitor-Space Profiler'
}

{ #category : #comparing }
GtMonitorOpenedSpace >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ space = anObject space
]

{ #category : #'gt-extension' }
GtMonitorOpenedSpace >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #accessing }
GtMonitorOpenedSpace >> gtPreviewFor: aView [
	<gtView>

	^ self space
		gtPreviewFor: aView
]

{ #category : #comparing }
GtMonitorOpenedSpace >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ space hash
]

{ #category : #testing }
GtMonitorOpenedSpace >> isDead [
	^ self isRunning not
]

{ #category : #testing }
GtMonitorOpenedSpace >> isRunning [
	^ self space isOpened
]

{ #category : #accessing }
GtMonitorOpenedSpace >> pointers [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ self space pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ] ]
		ifFalse: [ {  } ]
]

{ #category : #accessing }
GtMonitorOpenedSpace >> space [
	<return: #BlSpace>

	^ space
]

{ #category : #accessing }
GtMonitorOpenedSpace >> space: aSpace [
	space := aSpace
]

{ #category : #accessing }
GtMonitorOpenedSpace >> title [
	^ self space title
]

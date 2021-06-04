"
I represent a profiled space
"
Class {
	#name : #GtProfilerSpace,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Profiler'
}

{ #category : #comparing }
GtProfilerSpace >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ space = anObject space
]

{ #category : #'gt-extension' }
GtProfilerSpace >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #accessing }
GtProfilerSpace >> gtPreviewFor: aView [
	<gtView>

	^ self space
		gtPreviewFor: aView
]

{ #category : #comparing }
GtProfilerSpace >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ space hash
]

{ #category : #testing }
GtProfilerSpace >> isRunning [
	^ self space isOpened
]

{ #category : #accessing }
GtProfilerSpace >> pointers [
	Smalltalk garbageCollectMost.

	^ self space pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ]
]

{ #category : #accessing }
GtProfilerSpace >> space [
	<return: #BlSpace>

	^ space
]

{ #category : #accessing }
GtProfilerSpace >> space: aSpace [
	space := aSpace
]

{ #category : #accessing }
GtProfilerSpace >> title [
	^ self space title
]

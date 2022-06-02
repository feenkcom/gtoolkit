Class {
	#name : #GtTallyExamples,
	#superclass : #Object,
	#category : #'GToolkit-Profiler'
}

{ #category : #accessing }
GtTallyExamples >> createSpyAllOn [
	<gtExample>
	| tally |
	tally := GtTally new spyAllProcessesEvery: 1 forMilliseconds: 3000.
	^tally
]

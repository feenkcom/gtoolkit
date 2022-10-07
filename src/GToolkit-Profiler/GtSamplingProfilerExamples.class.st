Class {
	#name : #GtSamplingProfilerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Profiler'
}

{ #category : #accessing }
GtSamplingProfilerExamples >> createSpyAllOn [
	<gtExample>
	| tally |
	tally := GtSamplingProfiler spyAllProcessesFor: 2 seconds.
	^ tally
]

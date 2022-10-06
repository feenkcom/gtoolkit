Class {
	#name : #GtSamplingProfilerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Profiler'
}

{ #category : #accessing }
GtSamplingProfilerExamples >> createSpyAllOn [
	<gtExample>
	| tally |
	tally := GtSamplingProfiler spyAllProcessesEvery: 1 forMilliseconds: 2000.
	^ tally
]

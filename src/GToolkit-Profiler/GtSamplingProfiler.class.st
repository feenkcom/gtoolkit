Class {
	#name : #GtSamplingProfiler,
	#superclass : #Object,
	#instVars : [
		'rootTally',
		'gcStats',
		'time'
	],
	#category : #'GToolkit-Profiler'
}

{ #category : #accessing }
GtSamplingProfiler class >> spyAllProcessesEvery: millisecs forMilliseconds: msecDuration [
	^ self new spyAllProcessesEvery: millisecs forMilliseconds: msecDuration
]

{ #category : #accessing }
GtSamplingProfiler class >> spyAllProcessesEvery: millisecs while: aBlock [
	^ self new spyAllProcessesEvery: millisecs while: aBlock
]

{ #category : #accessing }
GtSamplingProfiler class >> spyAllProcessesForMilliseconds: msecDuration [
	^ self spyAllProcessesEvery: 1 forMilliseconds: msecDuration
]

{ #category : #accessing }
GtSamplingProfiler class >> spyAllProcessesWhile: aBlock [
	^ self spyAllProcessesEvery: 1 while: aBlock
]

{ #category : #accessing }
GtSamplingProfiler class >> spyOn: aBlock [
	^ self new spyOn: aBlock every: 1
]

{ #category : #printing }
GtSamplingProfiler >> fullPrintOn: aStream threshold: percent [
	| threshold |
	threshold := (percent asFloat / 100 * rootTally tally) rounded.
	aStream
		nextPutAll: '**Tree**';
		cr.
	rootTally
		rootPrintOn: aStream
		total: rootTally tally
		totalTime: time
		threshold: threshold.
	aStream
		nextPut: Character newPage;
		cr
]

{ #category : #inspecting }
GtSamplingProfiler >> gtGroupedByMethodFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Top local tallies';
		priority: 11;
		object: [ rootTally];
		view: #gtGroupedByMethodFor:
]

{ #category : #inspecting }
GtSamplingProfiler >> gtMessagesTreeIn: aView [
	<gtView>
	^ aView forward
		title: 'Tree';
		priority: 10;
		object: [ rootTally ];
		view: #gtMessagesTreeIn:
]

{ #category : #inspecting }
GtSamplingProfiler >> gtPreviewFor: aView [
	^ aView empty
]

{ #category : #inspecting }
GtSamplingProfiler >> gtRecursionSummaryMessagesTreeIn: aView [
	<gtView>
	^ aView forward
		title: 'Summarize Recursion';
		priority: 10;
		object: [ rootTally ];
		view: #gtRecursionSummaryMessagesTreeIn:
]

{ #category : #inspecting }
GtSamplingProfiler >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ rootTally ];
		view: #gtSourceFor:
]

{ #category : #inspecting }
GtSamplingProfiler >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		aptitude: BrGlamorousCodeEditorAptitude;
		priority: 60;
		text: [ String streamContents: [ :s | self report: s ] ]
]

{ #category : #printing }
GtSamplingProfiler >> report: aStream [
	self report: aStream cutoff: 1
]

{ #category : #printing }
GtSamplingProfiler >> report: aStream cutoff: threshold [
	rootTally tally = 0
		ifTrue: [ aStream nextPutAll: ' - no tallies obtained' ]
		ifFalse: [ aStream
				nextPutAll: ' - ';
				print: rootTally tally;
				nextPutAll: ' tallies, ' , time printString , ' msec.';
				cr;
				cr.
			self fullPrintOn: aStream threshold: threshold ].
	time isZero ifFalse: [ self reportGCStatsOn: aStream ]
]

{ #category : #printing }
GtSamplingProfiler >> reportGCStatsOn: aStream [
	| oldSpaceEnd youngSpaceEnd memoryEnd fullGCs fullGCTime incrGCs incrGCTime tenureCount upTime rootOverflows |
	upTime := time.
	oldSpaceEnd := gcStats at: 1.
	youngSpaceEnd := gcStats at: 2.
	memoryEnd := gcStats at: 3.
	fullGCs := gcStats at: 7.
	fullGCTime := gcStats at: 8.
	incrGCs := gcStats at: 9.
	incrGCTime := gcStats at: 10.
	tenureCount := gcStats at: 11.
	rootOverflows := gcStats at: 22.

	aStream cr.
	aStream
		nextPutAll: '**Memory**';
		cr.
	aStream nextPutAll: '	old			'.
	oldSpaceEnd printWithCommasSignedOn: aStream.
	aStream
		nextPutAll: ' bytes';
		cr.
	aStream nextPutAll: '	young		'.
	youngSpaceEnd - oldSpaceEnd printWithCommasSignedOn: aStream.
	aStream
		nextPutAll: ' bytes';
		cr.
	aStream nextPutAll: '	used		'.
	youngSpaceEnd printWithCommasSignedOn: aStream.
	aStream
		nextPutAll: ' bytes';
		cr.
	aStream nextPutAll: '	free		'.
	memoryEnd - youngSpaceEnd printWithCommasSignedOn: aStream.
	aStream
		nextPutAll: ' bytes';
		cr.

	aStream cr.
	aStream
		nextPutAll: '**GCs**';
		cr.
	aStream
		nextPutAll: '	full			';
		print: fullGCs;
		nextPutAll: ' totalling '.
	fullGCTime printWithCommasOn: aStream.
	aStream
		nextPutAll: 'ms (';
		print: (fullGCTime / upTime * 100 roundTo: 1.0);
		nextPutAll: '% uptime)'.
	fullGCs = 0
		ifFalse: [ aStream
				nextPutAll: ', avg ';
				print: (fullGCTime / fullGCs roundTo: 1.0);
				nextPutAll: 'ms' ].
	aStream cr.
	aStream
		nextPutAll: '	incr		';
		print: incrGCs;
		nextPutAll: ' totalling '.
	incrGCTime printWithCommasOn: aStream.
	aStream
		nextPutAll: 'ms (';
		print: (incrGCTime / upTime * 100 roundTo: 1.0);
		nextPutAll: '% uptime)'.
	incrGCs = 0
		ifFalse: [ aStream
				nextPutAll: ', avg ';
				print: (incrGCTime / incrGCs roundTo: 1.0);
				nextPutAll: 'ms' ].
	aStream cr.
	aStream nextPutAll: '	tenures		'.
	tenureCount printWithCommasOn: aStream.
	tenureCount = 0
		ifFalse: [ aStream
				nextPutAll: ' (avg ';
				print: (incrGCs / tenureCount) asInteger;
				nextPutAll: ' GCs/tenure)' ].
	aStream cr.
	aStream nextPutAll: '	root table	'.
	rootOverflows printWithCommasOn: aStream.
	aStream nextPutAll: ' overflows'.
	aStream cr
]

{ #category : #accessing }
GtSamplingProfiler >> spyAllProcessesEvery: millisecs forMilliseconds: msecDuration [
	| endTime |
	endTime := Time millisecondClockValue + msecDuration.
	^ self
		spyAllProcessesEvery: millisecs
		while: [ Time millisecondClockValue < endTime ]
]

{ #category : #accessing }
GtSamplingProfiler >> spyAllProcessesEvery: millisecs while: aBlock [
	| myDelay sem processes startTime timer myPriority |
	myPriority := Processor timingPriority - 1.
	rootTally := GtTally new
			class: thisContext receiver class
			method: thisContext method.	"set up the probe"
	processes := Process allInstances
			select: [ :each | each priority <= myPriority ]
			thenCollect: [ :each | each -> each suspendedContext ].
	myDelay := Delay forMilliseconds: millisecs.
	sem := Semaphore new.
	gcStats := Smalltalk vm getParameters.
	timer := [ [ | start |
		start := Time microsecondClockValue.
		myDelay wait.
		processes
			do: [ :each | 
				each key suspendedContext ~= each value
					ifTrue: [ rootTally
							tally: each key suspendedContext
							in: each key
							by: (((Time microsecondClockValue - start) / 1000.0) rounded max: 1).
						each value: each key suspendedContext ] ].
		aBlock value ] whileTrue.
		sem signal ] newProcess.
	startTime := Time microsecondClockValue.
	timer priority: myPriority.	"activate the probe and evaluate the block"
	timer resume.

	^ [ sem wait.
	timer terminate.
	Smalltalk vm getParameters
		keysAndValuesDo: [ :idx :gcVal | gcVal isNumber ifTrue: [ gcStats at: idx put: gcVal - (gcStats at: idx) ] ].
	time := Time microsecondClockValue - startTime / 1000.0.
	self ] asAsyncPromise
]

{ #category : #accessing }
GtSamplingProfiler >> spyOn: aBlock every: milliseconds [
	| myDelay process startTime timer myPriority |
	myPriority := Processor timingPriority - 1.
	rootTally := GtTally new
			class: thisContext receiver class
			method: thisContext method.
	myDelay := Delay forMilliseconds: milliseconds.
	gcStats := Smalltalk vm getParameters.
	process := Processor activeProcess.
	timer := [ [ | start |
		start := Time microsecondClockValue.
		myDelay wait.
		process isTerminated
			ifTrue: [ true ]
			ifFalse: [ rootTally
					tally: process suspendedContext
					in: process
					by: (((Time microsecondClockValue - start) / 1000.0) rounded max: 1).
				false ] ] whileFalse ] newProcess.
	startTime := Time microsecondClockValue.
	timer priority: myPriority.	"activate the probe and evaluate the block"
	timer resume.
	[ aBlock value	"in case someone doesn't pass a block" ]
		ensure: [ timer terminate ].
	Smalltalk vm getParameters
		keysAndValuesDo: [ :idx :gcVal | gcVal isNumber ifTrue: [ gcStats at: idx put: gcVal - (gcStats at: idx) ] ].
	time := Time microsecondClockValue - startTime / 1000.0
]

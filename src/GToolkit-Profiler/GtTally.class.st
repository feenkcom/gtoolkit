Class {
	#name : #GtTally,
	#superclass : #Object,
	#instVars : [
		'gcStats',
		'time',
		'class',
		'method',
		'tally',
		'receivers',
		'process'
	],
	#category : #'GToolkit-Profiler'
}

{ #category : #inspecting }
GtTally >> addReceiver: aMessageTally [
	receivers := receivers copyWith: aMessageTally
]

{ #category : #filtering }
GtTally >> applyFilter: aGtMessageTallyFilter [
	^ aGtMessageTallyFilter filter: self
]

{ #category : #accessing }
GtTally >> bumpBy: count [
	tally := tally + count
]

{ #category : #inspecting }
GtTally >> changeToOuterMethod [
	method := method method
]

{ #category : #accessing }
GtTally >> children [
	^ self sonsOver: 0
]

{ #category : #initialize }
GtTally >> class: aClass method: aMethod [
	class := aClass.
	method := aMethod.
	tally := 0.
	receivers := Array new: 0
]

{ #category : #filtering }
GtTally >> filterCopy [
	^ self copy filterPostCopy
]

{ #category : #filtering }
GtTally >> filterPostCopy [
	receivers := Array new: 0.
]

{ #category : #printing }
GtTally >> fullPrintExactOn: aStream [
	aStream nextPutAll: '**Tree**'; cr.
	self
		treePrintOn: aStream
		tabs: OrderedCollection new
		thisTab: ''
		total: tally
		totalTime: time
		tallyExact: true
		orThreshold: nil.
	aStream nextPut: Character newPage; cr.
	aStream nextPutAll: '**Leaves**'; cr.
	self leavesPrintExactOn: aStream
]

{ #category : #printing }
GtTally >> fullPrintOn: aStream threshold: perCent [
	| threshold |  
	threshold := (perCent asFloat / 100 * tally) rounded.
	aStream nextPutAll: '**Tree**'; cr.
	self
		rootPrintOn: aStream
		total: tally
		totalTime: time
		threshold: threshold.
	aStream nextPut: Character newPage; cr.
	"aStream nextPutAll: '**Leaves**'; cr.
	self
		leavesPrintOn: aStream
		threshold: threshold"
]

{ #category : #inspecting }
GtTally >> gtDisplayIdentifierOn: aStream [
	class displayStringOn: aStream.
	self method methodClass ~~ class 
		ifTrue: [ aStream nextPut: $(; print: self method methodClass; nextPut: $) ].
	aStream 
		nextPutAll: '>>';
		store: self method selector
]

{ #category : #inspecting }
GtTally >> gtDisplayOn: aStream [
	self gtDisplayIdentifierOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self tally printString;
		nextPutAll: ')'
]

{ #category : #inspecting }
GtTally >> gtGroupedByMethodFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Top local tallies';
		priority: 11;
		stencil: [ 
			| grouped barChart tallies data maxTally aBarWidthScale aBarHeightScale |
			tallies := self deepCollect: #children.
			data := GtPlotterDataGroup new values: tallies.
			grouped := data 
				groupedBy: #method 
				sorted: [:a :b | (a value sumNumbers: #localTally) > (b value sumNumbers: #localTally)] 
				decorated: [ :each |  {
					GtPlotterDataGroupWithLabel new label: (each gtDisplayString).
					GtPlotterDataGroupWithColor new color: (Color r: 216 g: 55 b: 62 range: 255)} ].
			maxTally := data inject: 0 intoValues: [ :anAmount :eachValue | anAmount max: (eachValue localTally) ].
			aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: maxTally.
			aBarHeightScale := GtPlotterLinearScale new
		domainFrom: 0 to: (grouped entities max: #size);
		rangeFrom: 2 to: 50.
			barChart := GtPlotterHorizontalBarChart new.
			barChart withAdjacentBars.
			barChart groupSpacing: 10.
			barChart barLabelWidth: 300.
			barChart barLabelAptitudeStencil: [ BrGlamorousLabelAptitude new glamorousRegularFont; fontSize: 10 ].
			barChart barWidthScale: aBarWidthScale.
			barChart barWidthData: [ :eachValue | eachValue localTally ].
			barChart barHeightScale: aBarHeightScale.
			barChart barHeightData: [ :eachGroup | eachGroup size * 2 ].
			barChart amountOfTicks: 4.
			barChart with: grouped.
			barChart asElement	 ]
]

{ #category : #inspecting }
GtTally >> gtInspectorReportIn: composite [
	<gtInspectorPresentationOrder: 60>
	^ composite text
		title: 'Report';
		display: [ String streamContents: [:s | self report: s ] ]
]

{ #category : #inspecting }
GtTally >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ self method ifNotNil: [
		self method gtInspectorSourceIn: composite]
]

{ #category : #inspecting }
GtTally >> gtMessagesTreeIn: aView [
	<gtView>
	
	| methods normalizer |
	methods := self withDeepCollect: #children.
	normalizer := BrColorLinearNormalizer
		inContext: methods
		withCommand: #tally
		lowColor: Color gray
		highColor:
			(Color
				r: 216
				g: 55
				b: 62
				range: 255).
	^ (aView columnedTree)
		title: 'Tree';
		priority: 10;
		expandSuchThat: [ :aNode :aMessageTally | aMessageTally tally / (self tally max: 0.1) > 0.15 ];
		items: [ {self} ];
		children: [ :each | each children ];
		column: 'Method'
			do:
				[ :aColumn | 
					aColumn
						cellStencil:
								[ (BrLabel new)
										aptitude: BrGlamorousLabelAptitude new;
										addAptitude:
												(BrGlamorousWithContextMenuAptitude
														content:
															[ (BrGlamorousSimpleContextMenuContent new)
																items:
																		{'Gather'
																					->
																						[ :e | e phlow spawnObject: (self applyFilter: (GtGatherMessageTallyFilter forMethod: (e userData at: #method))) ]};
																yourself ]) ];
						dataBinder:
								[ :eachLabel :each | 
									eachLabel userData at: #method put: each method.
									eachLabel text: (each method gtDisplayString asRopedText glamorousRegularFont foreground: (normalizer value: each)) ] ];
		column: 'Percent'
			text:
				[ :each | 
				((each tally / (self tally max: 0.1) asFloat * 100 printShowingDecimalPlaces: 1) , '%') asRopedText glamorousRegularFont
					foreground: (normalizer value: each) ]
			width: 100;
		column: 'Tally'
			text: [ :each | each tally asString asRopedText glamorousRegularFont foreground: (normalizer value: each) ]
			width: 100
]

{ #category : #inspecting }
GtTally >> gtPreviewFor: aView [
	^ aView empty
]

{ #category : #inspecting }
GtTally >> gtRecursionSummaryMessagesTreeIn: aView [
	<gtView>
	
	^ aView forward
		title: 'Summarize Recursion';
		priority: 10;
		object: [ self applyFilter: GtRecursionSummaryFilter new ];
		view: #gtMessagesTreeIn:
]

{ #category : #inspecting }
GtTally >> gtSourceFor: aView [
	<gtView>
	self method ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self method method ];
		view: #gtSourceFor:
]

{ #category : #inspecting }
GtTally >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		aptitude: BrGlamorousCodeEditorAptitude;
		priority: 60;
		text: [ String streamContents: [:s | self report: s ] ]
]

{ #category : #initialize }
GtTally >> initialize [
	time := 0.
	tally := 0
]

{ #category : #accessing }
GtTally >> isPrimitives [
	"Detect pseudo node used to carry tally of local hits"
	^ receivers isNil
]

{ #category : #printing }
GtTally >> leavesInto: leafDict fromSender: senderTally [
	| rcvrs |
	rcvrs := self sonsOver: 0.
	rcvrs isEmpty
		ifTrue: [ self into: leafDict fromSender: senderTally ]
		ifFalse: [ rcvrs anyOne process isNil ifTrue: [ ^ self ].
			rcvrs
				do: [ :node | 
					node isPrimitives
						ifTrue: [ node leavesInto: leafDict fromSender: senderTally ]
						ifFalse: [ node leavesInto: leafDict fromSender: self ] ] ]
]

{ #category : #printing }
GtTally >> leavesPrintOn: aStream threshold: threshold [
	| dict |
	dict := IdentityDictionary new: 100.
	self leavesInto: dict fromSender: nil.
	(dict asOrderedCollection
			select: [:node | node tally > threshold])
		asSortedCollection do: [:node |
			node printOn: aStream total: tally totalTime: time tallyExact: false ]
]

{ #category : #accessing }
GtTally >> localTally [
	^ self children 
		inject: self tally
		into: [ :diff :each | diff - each tally ]
]

{ #category : #accessing }
GtTally >> method [
	^ method
]

{ #category : #accessing }
GtTally >> method: aMethod [
	method := aMethod
]

{ #category : #accessing }
GtTally >> primitives: anInteger [
	tally := anInteger.
	receivers := nil
]

{ #category : #printing }
GtTally >> printOn: aStream total: total totalTime: totalTime tallyExact: isExact [
	isExact
		ifTrue: [ | myTally |
			myTally := tally.
			receivers == nil
				ifFalse: [ receivers do: [ :r | myTally := myTally - r tally ] ].
			aStream
				print: myTally;
				space ]
		ifFalse: [ | percentage |
			percentage := tally asFloat / total * 100.0.
			aStream
				nextPutAll: (percentage printShowingDecimalPlaces: 1);
				nextPutAll: '% {';
				print: (percentage * totalTime / 100) rounded;
				nextPutAll: 'ms} ' ].
	receivers
		ifNil: [ aStream
				nextPutAll: 'primitives';
				cr ]
		ifNotNil: [ | className aSelector aClass |
			aSelector := method selector.
			aClass := method methodClass.
			className := aClass name.
			aStream
				nextPutAll: class name;
				nextPutAll: (aClass = class ifTrue: [ '>>' ] ifFalse: [ '(' , aClass name , ')>>' ]);
				nextPutAll: aSelector;
				cr ]
]

{ #category : #accessing }
GtTally >> process [

	^ process
]

{ #category : #accessing }
GtTally >> process: aProcess [
	process := aProcess
]

{ #category : #accessing }
GtTally >> receivers [
	^ receivers
]

{ #category : #printing }
GtTally >> report: strm [ 
	"Print a report, with cutoff percentage of each element of the tree 
	(leaves, roots, tree), on the stream, strm."

	self report: strm cutoff: 1
]

{ #category : #printing }
GtTally >> report: strm cutoff: threshold [ 
	tally = 0
		ifTrue: [strm nextPutAll: ' - no tallies obtained']
		ifFalse: 
			[strm nextPutAll: ' - '; print: tally; nextPutAll: ' tallies, ', time printString, ' msec.'; cr; cr.
			self fullPrintOn: strm threshold: threshold].
		
	time isZero ifFalse:	
		[self reportGCStatsOn: strm].
]

{ #category : #printing }
GtTally >> rootPrintOn: aStream total: total totalTime: totalTime threshold: threshold [
	| groups |
	groups := (self sonsOver: threshold)
			groupedBy: [ :aTally | aTally process ]
			having: [ :g | true ].
	groups
		do: [ :g | 
			| sons p |
			sons := g asArray sort.
			p := g anyOne process.
			p notNil
				ifTrue: [ aStream
						nextPutAll: '--------------------------------';
						cr.
					aStream
						nextPutAll: 'Process: '
								, (p ifNil: [ 'other processes' ] ifNotNil: [ p browserPrintString ]);
						cr.
					aStream
						nextPutAll: '--------------------------------';
						cr.
					sons
						do: [ :son | 
							son
								treePrintOn: aStream
								tabs: OrderedCollection new
								thisTab: ''
								total: total
								totalTime: totalTime
								tallyExact: false
								orThreshold: threshold ] ] ]
]

{ #category : #accessing }
GtTally >> setMethod: aMethod [
	method := aMethod
]

{ #category : #accessing }
GtTally >> sonsOver: threshold [
	"Returns all the sons that are not below a certain threshold. threshold is a number."

	| hereTally sons |
	(receivers isNil or: [ receivers isEmpty ]) ifTrue: [ ^ #() ].
	hereTally := tally.
	sons := receivers
			select: [  :son | 
				"subtract subNode tallies for primitive hits here"
				hereTally := hereTally - son tally.
				son tally > threshold ].
	hereTally > threshold
		ifTrue: [ | last |
			last := self class new class: class method: method.
			last process: process.
			^ sons copyWith: (last primitives: hereTally) ].
	^ sons
]

{ #category : #tallying }
GtTally >> spyAllProcessesEvery: millisecs forMilliseconds: msecDuration [
	| endTime |
	endTime := Time millisecondClockValue + msecDuration.
	^ self
		spyAllProcessesEvery: millisecs
		while: [ Time millisecondClockValue < endTime ]
]

{ #category : #tallying }
GtTally >> spyAllProcessesEvery: millisecs while: aBlock [
	| myDelay sem processes startTime timer |
	self class: thisContext receiver class method: thisContext method.	"set up the probe"
	processes := Process allInstances
			select: [ :each | each priority <= (Processor timingPriority - 1) ]
			thenCollect: [ :each | each -> each suspendedContext ].
	myDelay := Delay forMilliseconds: millisecs.
	sem := Semaphore new.
	gcStats := Smalltalk vm getParameters.
	timer := [ [ myDelay wait.
		processes
			do: [ :each | 
				each key suspendedContext ~= each value
					ifTrue: [ self
							tally: each key suspendedContext
							in: each key
							by: 1.
						each value: each key suspendedContext ] ].
		aBlock value ] whileTrue.
		sem signal ] newProcess.
	startTime := Time millisecondClockValue.
	timer priority: Processor timingPriority - 1.	"activate the probe and evaluate the block"
	timer resume.	"activate the probe and wait for it to finish"
	sem wait.
	timer terminate.
	Smalltalk vm getParameters
		keysAndValuesDo: [ :idx :gcVal | gcVal isNumber ifTrue: [ gcStats at: idx put: gcVal - (gcStats at: idx) ] ].
	time := Time millisecondClockValue - startTime
]

{ #category : #accessing }
GtTally >> tally [
	^ tally
]

{ #category : #tallying }
GtTally >> tally: context in: aProcess by: count [
	"Explicitly tally the specified context and its stack."
	| sender |

	"Add to this node if appropriate"
	context method == method ifTrue: [^self bumpBy: count].
	
	"No sender? Add new branch to the tree."
	(sender := context sender) ifNil: [
		^ (self bumpBy: count) tallyPath: context in: aProcess by: count].
	
	"Find the node for the sending context (or add it if necessary)"
	^ (self tally: sender in: aProcess by: count) tallyPath: context in: aProcess by: count
]

{ #category : #tallying }
GtTally >> tallyPath: context in: aProcess by: count [
	| aMethod path |
	aMethod := context method.
	
	"Find the correct child (if there)"
	receivers do: [ :oldTally | 
		(oldTally method == aMethod and: [oldTally process == aProcess])
			ifTrue: [path := oldTally]].

	"Add new child if needed"
	path ifNil:[
		path := self class new class: context receiver class method: aMethod;
			process: aProcess.
		receivers := receivers copyWith: path].

	^ path bumpBy: count
]

{ #category : #accessing }
GtTally >> theClass [
	"Return the class of the object receiver related to this tally"
	
	 ^ class
]

{ #category : #printing }
GtTally >> treePrintOn: aStream tabs: tabs thisTab: myTab total: total totalTime: totalTime tallyExact: isExact orThreshold: threshold [
	| sons sonTab |
	tabs do: [ :tab | aStream nextPutAll: tab ].
	tabs size > 0
		ifTrue: [ self
				printOn: aStream
				total: total
				totalTime: totalTime
				tallyExact: isExact ].
	sons := isExact ifTrue: [ receivers ] ifFalse: [ self sonsOver: threshold ].
	sons isEmpty
		ifFalse: [ tabs addLast: myTab.
			sons := sons asSortedCollection: [:a :b | a tally <= b tally].
			1
				to: sons size
				do: [ :i | 
					sonTab := i < sons size ifTrue: [ '  |' ] ifFalse: [ '  ' ].
					(sons at: i)
						treePrintOn: aStream
						tabs: tabs
						thisTab: sonTab
						total: total
						totalTime: totalTime
						tallyExact: isExact
						orThreshold: threshold ].
			tabs removeLast ]
]

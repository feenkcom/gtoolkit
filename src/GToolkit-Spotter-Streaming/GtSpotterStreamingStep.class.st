Class {
	#name : #GtSpotterStreamingStep,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'processors',
		'origin',
		'context',
		'selected',
		'stream',
		'candidates',
		'asyncTask',
		'spotter',
		'lastSearchContext',
		'event',
		'hasActedOn'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #example }
GtSpotterStreamingStep class >> gtExampleBasic [
	<gtExample>
	^ self new
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> actDueTo: anEventType from: aSpotterElement [
	"Perform an action associated with currently selected item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	self
		assert: [ self hasSelected ]
		description: [ 'Spotter can not perform an action due to ', anEventType asString, ' if there is no selected candidate' ].

	self actOn: self selected dueTo: anEventType from: aSpotterElement
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> actOn: aCandidate dueTo: anEventType from: aSpotterElement [
	"Perform an action associated with the given candidate item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	| anAnnouncement aCantidateProcessor anObjectToActOn |
	self
		assert: [ aCandidate isNotNil ]
		description: [ 'Spotter can not perform an action due to ', 
			anEventType asString, 
			' if there is no candidate' ].

	hasActedOn := true.
	self terminateProcessors.

	self spotter historize: aCandidate.
	
	aCantidateProcessor := aCandidate processor.
	anObjectToActOn := aCantidateProcessor objectToActOn: aCandidate item from: self.
	
	anAnnouncement := self spotter notifyActOn: anObjectToActOn for: anEventType.
	anAnnouncement isActedUpon
		ifFalse: [ aCantidateProcessor actOn: anObjectToActOn for: self from: aSpotterElement ]
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> actOnCategory: aProcessorCadidates dueTo: anEventType from: aSpotterElement [
	"Perform an action associated with currently selected item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	| anAnnouncement anObjectToActOn theItems |
	self
		assert: [ aProcessorCadidates isNotNil ]
		description: [ 'Spotter can not perform an action due to ', 
			anEventType asString, 
			' if there are no candidates' ].

	hasActedOn := true.
	self terminateProcessors.

	aProcessorCadidates processor allFilteredCandidatesDo: [ :allCandidates | 
		theItems := allCandidates ].
	theItems ifNil: [
		theItems := aProcessorCadidates children collect: #item ].
	
	anObjectToActOn := theItems 
		collect: [ :eachItem | 
			aProcessorCadidates processor objectToActOn: eachItem from: self ]
		as: Array.
	
	anAnnouncement := self spotter notifyActOn: anObjectToActOn for: anEventType.
	anAnnouncement isActedUpon
		ifFalse: [ aProcessorCadidates processor actOnCategory: anObjectToActOn for: self from: aSpotterElement ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> addProcessor: aProcessor [
	self processors add: aProcessor
]

{ #category : #accessing }
GtSpotterStreamingStep >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
GtSpotterStreamingStep >> asElement [
	^ GtSpotterStepElement new stepModel: self
]

{ #category : #accessing }
GtSpotterStreamingStep >> asyncTask [

	^ asyncTask
]

{ #category : #accessing }
GtSpotterStreamingStep >> asyncTask: anAsyncTask [
	asyncTask := anAsyncTask
]

{ #category : #accessing }
GtSpotterStreamingStep >> attachedTo: anElement [
	stream attachedTo: anElement
]

{ #category : #private }
GtSpotterStreamingStep >> basicRelevantProcessorsProcess: aSpotterContext [
	self basicRelevantProcessorsProcess: aSpotterContext do: [ :eachProcessor | 
		self hasActedOn ifFalse: [ 
			eachProcessor filterInContext: aSpotterContext ] ].
	aSpotterContext continueFilter
]

{ #category : #private }
GtSpotterStreamingStep >> basicRelevantProcessorsProcess: aSpotterContext do: aBlock [
	| theSortedProcessors |
	
	theSortedProcessors := self processors sorted: [ :a :b | a priority < b priority ].

	aSpotterContext text substrings 
		detect: [ :each | each beginsWith: '#' ]
		ifFound: [ :categoryQuery | 
			| categoryQueryPrefix |
			aSpotterContext text: (aSpotterContext text copyReplaceAll: categoryQuery with: '').
			categoryQueryPrefix := categoryQuery allButFirst asLowercase.
			theSortedProcessors
				select: [ :each | 
					self 
						processor: each 
						isRelevantForQuery: categoryQueryPrefix ]
				thenDo: aBlock ]
		ifNone: [ 
			theSortedProcessors do: aBlock ]
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> canDiveIn: aCandidate [
	| newFakeStep canDiveIn|
	canDiveIn := false.
	newFakeStep := self spotter newStep origin: self origin.
	self spotter
		addStep: newFakeStep
		during: [ aCandidate gtSpotterProcessorsFor: newFakeStep.
			canDiveIn := newFakeStep processors notEmpty ].
	^ canDiveIn
]

{ #category : #'api - accessing' }
GtSpotterStreamingStep >> candidates [
	^ candidates
]

{ #category : #processing }
GtSpotterStreamingStep >> configureProcessorsStartingAt: anIndex pragma: aPragma with: aConfigurationBlock [
	"Execute aConfigurationBlock with all processors starting at anIndex.
	(this assumes processors are stored in an OrderedCollection that captures the
	orderin which they are added to the step.)"
	
	(anIndex > self processors size) ifTrue: [ ^ self ].
	anIndex to: self processors size do: [ :processorIndex |
		| aProcessor |
		aProcessor := self processors at: processorIndex.
		aProcessor definingMethod: aPragma method.
		aConfigurationBlock value: aProcessor ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> context [
	<return: #GtSpotterContext>

	^ context
]

{ #category : #accessing }
GtSpotterStreamingStep >> context: aGtSpotterContext [
	context := aGtSpotterContext
]

{ #category : #initialization }
GtSpotterStreamingStep >> defaultStream [
	^ GtSpotterUIThreadStream new
]

{ #category : #initialization }
GtSpotterStreamingStep >> defaultTask [
	^ GtSpotterAsyncTask new
]

{ #category : #selecting }
GtSpotterStreamingStep >> deselect [
	| anAlreadySelected |
	
	self hasSelected
		ifFalse: [ ^ self ].
	
	anAlreadySelected := self selected.
	selected := nil.
	self notifyCandidateDeselected: anAlreadySelected
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveIn [
	self diveInDueTo: #undefined
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveIn: aCandidate dueTo: anEventType [
	(self canDiveIn: aCandidate) ifTrue: [ 
		self spotter
			historize: aCandidate;
			requestNextStepWith: aCandidate item for: #diveIn;
			notifyDiveIn: aCandidate item for: anEventType ]
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveInCategory [
	"dive in category of selected candidate"
	^ self diveInCategoryDueTo: #unknown
	
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveInCategory: aProcessor dueTo: anEventType [
	"dive in specified aCategory"

	self spotter
		requestNextCategoryStepWith: (self candidates getProcessorLink: aProcessor) for: #diveInCategory;
		notifyDiveInCategory: aProcessor for: anEventType
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveInCategoryDueTo: anEventType [
	"dive in category of selected candidate"

	self diveInCategory: self selected processor dueTo: anEventType
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveInDueTo: anEventType [
	self diveIn: self selected dueTo: anEventType
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> diveOutDueTo: anEventType [
	self spotter
		requestPreviousStepFor: #diveOut;
		notifyDiveOut: self selected item
]

{ #category : #accessing }
GtSpotterStreamingStep >> event [
	^ event
]

{ #category : #accessing }
GtSpotterStreamingStep >> event: anObject [
	event := anObject
]

{ #category : #'accessing - dynamic' }
GtSpotterStreamingStep >> exceptionHandler [

	" #ifNil: is necessary because the sender chain of #spotterProcessorsFor:pragma: may have multiple callees outside of the exception handler (async) ... so we have to provide a global but yet easy fallback "
	^ GtCurrentSpotterExceptionHandler value ifNil: [
		self hasSpotter
			ifTrue: [ self spotter exceptionHandler ]
			ifFalse: [ GtSpotterDebuggingExceptionHandler new ] ]
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> exit [

	self spotter exit
]

{ #category : #'gt-extension' }
GtSpotterStreamingStep >> gtCandidatesFor: aView [
	<gtView>

	^ self candidates gtCandidatesFor: aView
]

{ #category : #printing }
GtSpotterStreamingStep >> gtDisplayText [
	^ self origin gtDisplayText
]

{ #category : #inspecting }
GtSpotterStreamingStep >> gtInspectorProcessorsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Processors';
		display: [ self processors ];
		format: #gtDisplayString;
		when: [ self spotter notNil ]
]

{ #category : #'gt-extension' }
GtSpotterStreamingStep >> gtProcessorsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Processors';
		items: [ self processors sorted: [ :a :b | a priority < b priority ] ];
		column: 'Name' text: [ :each | each title ];
		column: 'Priority' text: [ :each | each priority asString ];
		column: 'Visible by default' text: [:each | each wantsToDisplayOnEmptyQuery ]
]

{ #category : #'error handling' }
GtSpotterStreamingStep >> handleExceptionsDuring: aBlock [
	self exceptionHandler handleExceptionsDuring: aBlock
]

{ #category : #testing }
GtSpotterStreamingStep >> hasActedOn [
	^ hasActedOn
]

{ #category : #'api - testing' }
GtSpotterStreamingStep >> hasCandidates [
	"Return true if there are any candidates in all categories,
	false otherwise"
	<return: #Boolean>
	
	^ self candidates isNotEmpty
]

{ #category : #testing }
GtSpotterStreamingStep >> hasPreviousNavigationFromClass: aClass [
	"Return true if origin of the previous step is kind of aClass.
	Return false if there is no previous step or if origin is not a kind of aClass"
	<return: #Boolean>
	
	^ self hasPreviousStep and: [
		self previousStep origin isKindOf: aClass ]
]

{ #category : #testing }
GtSpotterStreamingStep >> hasPreviousStep [
	"Return true if there is previous step,
	meaning that I am not a first step in spotter,
	false otherwise"
	<return: #Boolean>
	
	^ self spotter hasSteps
		and: [ self spotter steps first ~= self ]
]

{ #category : #testing }
GtSpotterStreamingStep >> hasSelected [
	"Return true if there is a selected candidate, false otherwise"
	<return: #Boolean>
	
	^ selected isNotNil
]

{ #category : #testing }
GtSpotterStreamingStep >> hasSpotter [
	<return: #Boolean>
	
	^ spotter isNotNil
]

{ #category : #initialization }
GtSpotterStreamingStep >> initialize [
	super initialize.

	hasActedOn := false.
	asyncTask := self defaultTask.
	
	candidates := GtSpotterCandidates new.
	candidates announcer
		when: GtSpotterCandidateAdded
		send: #onCandidateAdded
		to: self.
	candidates announcer
		when: GtSpotterAllCandidatesAdded
		send: #onCandidateAdded
		to: self.
	candidates announcer
		when: GtSpotterAllCandidatesRemoved
		send: #onAllCandidateRemoved
		to: self.
	candidates.

	stream := self defaultStream.
	stream
		onAddedSelector: #add:;
		onAddedAllSelector: #addAll:;
		onRemoveSelector: #removeAllCandidatesOf:;
		receiver: candidates.
	stream.
	
	context := self newContextForQuery: ''
]

{ #category : #testing }
GtSpotterStreamingStep >> isCategorySelected: aProcessor [
	"Return true if a category assigned to aProcessor is currently selected,
	false otherwise"
	<return: #Boolean>
	
	^ self hasSelected and: [ self selected processor == aProcessor ]
]

{ #category : #testing }
GtSpotterStreamingStep >> isSelected: aCandidate [
	"Return true if aCandidate is currently selected,
	false otherwise"
	<return: #Boolean>
	
	^ self hasSelected and: [ self selected == aCandidate ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> listProcessor [
	| processor |
	processor := GtSpotterCandidatesListProcessor new.
	self addProcessor: processor.
	^ processor
]

{ #category : #processing }
GtSpotterStreamingStep >> newContextForQuery: aString [
	self
		assert: [ aString isNotNil ]
		description: [ 'Query must not be nil' ].

	^ GtSpotterContext new 
		step: self;
		stream: self stream;
		text: aString;
		search: aString;
		yourself
]

{ #category : #notifying }
GtSpotterStreamingStep >> notifyCandidateDeselected: aCandidate [
	self
		assert: [ aCandidate isNotNil ]
		description: [ 'aCandidate must not be nil' ].

	self announcer announce: (GtSpotterCandidateDeselected new candidate: aCandidate).
	
	self hasSpotter
		ifTrue: [ self spotter notifyCandidateDeselected: aCandidate ]
]

{ #category : #notifying }
GtSpotterStreamingStep >> notifyCategorySelected: aProcessor [
	self hasSpotter
		ifTrue: [ self spotter notifyCategorySelected: aProcessor ]
]

{ #category : #notifying }
GtSpotterStreamingStep >> notifyContextChangedFrom: aPreviousContext to: aCurrentContext [
	self hasSpotter
		ifTrue: [ self spotter notifyContextChangedFrom: aPreviousContext to: aCurrentContext ]
]

{ #category : #notifying }
GtSpotterStreamingStep >> notifySearchFinishedFor: aString processors: aCollectionOfProcessors [
	self hasSpotter
		ifTrue: [ self spotter notifySearchFinishedFor: aString processors: aCollectionOfProcessors ]
]

{ #category : #notifying }
GtSpotterStreamingStep >> notifySelectedCandidateChanged: aCandidate [
	
	self notifySelectedCandidateChanged: aCandidate for: #unknown
]

{ #category : #notifying }
GtSpotterStreamingStep >> notifySelectedCandidateChanged: aCandidate for: anEventType [
	self
		assert: [ aCandidate isNotNil ]
		description: [ 'aCandidate must not be nil' ].

	self announcer announce: (GtSpotterSelectedCandidateChanged new select: aCandidate).
	
	self hasSpotter
		ifTrue: [ self spotter notifyCandidateSelected: aCandidate for: anEventType ]
]

{ #category : #'event processing' }
GtSpotterStreamingStep >> onAllCandidateRemoved [
	self deselect
]

{ #category : #'event processing' }
GtSpotterStreamingStep >> onCandidateAdded [
	"Select first candidate item in the list if there is no already selected
	candidate and candidate list has at least one candidate"

	(self hasSelected not and: [ self hasCandidates ])
		ifTrue: [ self selectFirst ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> origin [

	^ origin
]

{ #category : #accessing }
GtSpotterStreamingStep >> origin: anObject [

	origin := anObject
]

{ #category : #accessing }
GtSpotterStreamingStep >> previousProcessorFrom: aCollection [
	aCollection do: [ :each | 
		each asGtSpotterCandidateLink processor ifNotNil: [ ^ each processor ] ]. " we assume they are all identical "
	^ GtSpotterCandidatesListProcessor new
		title: 'Items';
		filter: GtFilterSubstring;
		yourself
]

{ #category : #'accessing - dynamic' }
GtSpotterStreamingStep >> previousStep [
	"Return a spotter step before me which must exist,
	otherwise behavior is undefined."
	<return: #GtSpotterStep>
	self assert: self hasPreviousStep.
	
	^ self spotter steps at: 
			(self spotter steps indexOf: self) - 1
]

{ #category : #processing }
GtSpotterStreamingStep >> process: aString [
	"I do not accept empty queries or the same queries as before.
	If nil is passed, than an empty string will be processed. This approach is used to
	destinguish when user deletes last character in the search and when search field became
	empty after spawning new step"
	
	self
		assert: [ aString isNotNil ]
		description: [ 'Search query must not be nil' ].

	self context: (self newContextForQuery: aString).

	" updating timestamp in a stream, to prevent candidates from old process being shown "
	self stream updateTimestamp.

	self asyncTask
		execute: (GtSpotterTaskCommand new
			query: aString;
			context: self context;
			valuable: [ :aCurrentContext |
				self notifyContextChangedFrom: lastSearchContext to: aCurrentContext.
				self processContext: aCurrentContext ];
			argument: self context;
			onSuccessDo: [ self processCallback: aString ])
]

{ #category : #processing }
GtSpotterStreamingStep >> processCallback: aString [
	"Process callback is called from another process. We need to execute it from here"
	self stream performCallback: [ 
		lastSearchContext := self context. 
		self notifySearchFinishedFor: aString processors: self processors ]
]

{ #category : #processing }
GtSpotterStreamingStep >> processContext: aSpotterContext [
	self handleExceptionsDuring: [ 
		self stream removeAllCandidates.
		self relevantProcessorsProcess: aSpotterContext ]
]

{ #category : #processing }
GtSpotterStreamingStep >> processSync: aString [
	"I do not accept empty queries or the same queries as before.
	If nil is passed, than an empty string will be processed. This approach is used to
	destinguish when user deletes last character in the search and when search field became
	empty after spawning new step"
	
	self
		assert: [ aString isNotNil ]
		description: [ 'Search query must not be nil' ].

	self context: (self newContextForQuery: aString).

	" updating timestamp in a stream, to prevent candidates from old process being shown "
	self stream updateTimestamp.
	
	self notifyContextChangedFrom: lastSearchContext to: self context.
	self processContext: self context.

	lastSearchContext := self context. 
	self notifySearchFinishedFor: aString processors: self processors
]

{ #category : #private }
GtSpotterStreamingStep >> processor: aProcessor isRelevantForQuery: aString [
	| trimmedProcessorTitle |
	trimmedProcessorTitle := aProcessor title asLowercase 
										copyReplaceAll: String space
										with: ''.
	^ trimmedProcessorTitle beginsWith: aString
]

{ #category : #accessing }
GtSpotterStreamingStep >> processors [

	^ processors ifNil: [ 
		processors := OrderedCollection new.
		self origin gtSpotterProcessorsFor: self.
		processors ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> processors: aCollection [

	processors := aCollection
]

{ #category : #'accessing - dynamic' }
GtSpotterStreamingStep >> processorsFilter [
	<return: #GtSpotterProcessorFilter>

	^ self hasSpotter
		ifTrue: [ self spotter processorsFilter ]
		ifFalse: [ GtSpotterNullProcessorFilter new ]
]

{ #category : #private }
GtSpotterStreamingStep >> relevantProcessorsProcess: aSpotterContext [
	[ self basicRelevantProcessorsProcess: aSpotterContext ]
		on: Error
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in process: ', exception asString) traceCr ] ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> searchQuery [
	<return: #String>
	
	^ self context search
]

{ #category : #selecting }
GtSpotterStreamingStep >> select: aCandidate [
	"Select a given candidate due to unknown reason.
	It is not recommended to use this method, unless you really need to.
	Note: use #select:dueTo: to allow better usage statistics"
	
	self select: aCandidate dueTo: #unknown
]

{ #category : #selecting }
GtSpotterStreamingStep >> select: aCandidate dueTo: anEventType [
	"Select a given candidate due to provided event type.
	A selection reason is used for statistical purposes and helps us
	better understand how users use spotter and as result improve it.
	aCandidate must not be nil.
	anEventType must not be nil"

	self
		assert: [ aCandidate isNotNil ]
		description: [ 'Candidate link must not be nil' ].

	self
		assert: [ aCandidate processor isNotNil ]
		description: [ 'Candidate must have assigned category (processor)' ].
	
	"A given candidate is already selected, do nothing"
	(self isSelected: aCandidate)
		ifTrue: [ ^ self ].

	self selected: aCandidate.
	self notifySelectedCandidateChanged: aCandidate for: anEventType.

	(self isCategorySelected: aCandidate processor)
		ifFalse: [ self notifyCategorySelected: aCandidate processor ]
]

{ #category : #selecting }
GtSpotterStreamingStep >> selectFirst [
	"Select the first candidate.
	Note: there must be at least one candidate in order to select first,
	make sure to check #hasCandidates before using me"
	self
		assert: [ self candidates isNotEmpty ]
		description: [ 'There must be at least one candidate in order to select the first' ].

	self select: self candidates first
]

{ #category : #selecting }
GtSpotterStreamingStep >> selectNextCategory [
	| currentCategory nextCategory |

	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	nextCategory := self candidates nextProcessorLinkOf: currentCategory.
	
	self select: ((currentCategory = nextCategory)
		ifTrue: [ nextCategory tailLink ]
		ifFalse: [ nextCategory headLink ])
]

{ #category : #selecting }
GtSpotterStreamingStep >> selectNextDueTo: anEventType [
	| anIndex aNextCandidate |

	self
		assert: [ self hasSelected ]
		description: [ 'I must have selected candidate' ].
	
	self
		assert: [ self hasCandidates ]
		description: [ 'I must have candidates' ].

	anIndex := self candidates indexOf: self selected.
	aNextCandidate := self candidates at: (anIndex + 1 min: self candidates size).

	self select: aNextCandidate dueTo: anEventType
]

{ #category : #selecting }
GtSpotterStreamingStep >> selectPreviousCategory [
	|currentCategory previousCategory|
	self selected ifNil: [ ^ self ].
	
	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	previousCategory := self candidates previousProcessorLinkOf: currentCategory.
	
	self select: previousCategory headLink
]

{ #category : #selecting }
GtSpotterStreamingStep >> selectPreviousDueTo: anEventType [
	| anIndex aPreviousCandidate |
	
	self
		assert: [ self hasSelected ]
		description: [ 'I must have selected candidate' ].
	
	self
		assert: [ self hasCandidates ]
		description: [ 'I must have candidates' ].

	anIndex := self candidates indexOf: self selected.
	aPreviousCandidate := self candidates at: (anIndex - 1 max: 1).

	self select: aPreviousCandidate dueTo: anEventType
]

{ #category : #'accessing - selected' }
GtSpotterStreamingStep >> selected [
	"Return a candidate link (represented by double link) to allow fast access to
	next and previous candidate. In order to get actual candidate object behind
	the link send #candidate to it.
	selected can not be nil (always use hasSelected before using me)"
	<return: #GtSpotterCandidate>
	self
		assert: [ selected isNotNil ]
		description: [ 'Selected candidate can not be accessed where there is no one' ].

	^ selected
]

{ #category : #'private - accessing' }
GtSpotterStreamingStep >> selected: aCandidate [
	self 
		assert: [ aCandidate class = GtSpotterCandidate ] 
		description: [ 'Selected candidate must be a ', GtSpotterCandidate name, ' instance' ].
	selected := aCandidate
]

{ #category : #'accessing - selected' }
GtSpotterStreamingStep >> selectedCandidate [
	"Return an actual candidate object behind candidate link. 
	Note: Since selected link can not be accessed if there is no selected one,
	always check #hasSelected before using me"
	<return: #Object>

	^ self selected item
]

{ #category : #'accessing - selected' }
GtSpotterStreamingStep >> selectedCategory [
	"Return a category processor that produced a currently selected candidate.
	Note: Since selected link can not be accessed if there is no selected one,
	always check #hasSelected before using me"
	<return: #GtSpotterProcessor>
	
	^ self selected processor
]

{ #category : #accessing }
GtSpotterStreamingStep >> spotter [

	^ spotter
]

{ #category : #accessing }
GtSpotterStreamingStep >> spotter: aSpotter [
	spotter := aSpotter.
	spotter attachedElementDo: [ :anElement | self attachedTo: anElement ]
]

{ #category : #accessing }
GtSpotterStreamingStep >> stream [
	<return: #GtSpotterStream>

	^ stream
]

{ #category : #'api - actions' }
GtSpotterStreamingStep >> terminateProcessors [

	self asyncTask terminate
]

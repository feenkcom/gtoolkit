Class {
	#name : #GtPharoCommonSuiteMethodsCoderMediator,
	#superclass : #Object,
	#instVars : [
		'methodsCoder',
		'suiteModel',
		'suiteViewModel'
	],
	#classVars : [
		'CanSubscribeToMethodCoder'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #'api - settings' }
GtPharoCommonSuiteMethodsCoderMediator class >> canSubscribeToMethodCoder [
	^ CanSubscribeToMethodCoder = true
]

{ #category : #'api - settings' }
GtPharoCommonSuiteMethodsCoderMediator class >> disableSubscribeToMethodCoder [
	CanSubscribeToMethodCoder := false
]

{ #category : #'api - settings' }
GtPharoCommonSuiteMethodsCoderMediator class >> enableSubscribeToMethodCoder [
	CanSubscribeToMethodCoder := true
]

{ #category : #'api - instance creation' }
GtPharoCommonSuiteMethodsCoderMediator class >> forMethodsCoder: aMethodsCoder suiteModel: aSuiteModel viewModel: aSuiteViewModel [
	^ self new
		methodsCoder: aMethodsCoder;
		suiteModel: aSuiteModel;
		suiteViewModel: aSuiteViewModel;
		connect
]

{ #category : #'private - testing' }
GtPharoCommonSuiteMethodsCoderMediator >> canSubscribeToMethodCoder [
	^ self class canSubscribeToMethodCoder
]

{ #category : #'private - subscriptions' }
GtPharoCommonSuiteMethodsCoderMediator >> connect [
	"Create a new stream from the methodsCoder to suiteModel"

	self subclassResponsibility
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> mediatorLabel [
	^ ''
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> methodsCoder [

	^ methodsCoder 
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> methodsCoder: aMethodsCoder [
	self
		assert: [ methodsCoder isNil ]
		description: [ 'Methods coder can be initialized only once' ].
	methodsCoder := aMethodsCoder.

	aMethodsCoder
		when: GtStreamingCodersStreamChanged
		send: #onCodersStreamChanged:
		to: self
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCoderMethodAdded: anAnnouncement [
	GtPharoMethodCoderAddedSignal new
		mediator: self;
		announcement: anAnnouncement;
		emit.

	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCoderMethodModified: anAnnouncement [
	GtPharoMethodCoderModifiedSignal new
		mediator: self;
		announcement: anAnnouncement;
		emit.

	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCoderMethodRemoved: anAnnouncement [
	GtPharoMethodCoderRemovedSignal new
		mediator: self;
		announcement: anAnnouncement;
		emit.

	anAnnouncement coder ifNotNil: [ :aCoder | aCoder unsubscribe: self ].
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onCodersStreamChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	GtPharoCodersStreamChangedSignal new
		mediator: self;
		announcement: anAnnouncement;
		emit.

	((anAnnouncement isDueTo: GtStreamingCodersAddedReason)
		or: [ (anAnnouncement isDueTo: GtStreamingCodersRemovedReason)
				or: [ anAnnouncement isDueTo: GtStreamingCodersSwappedReason ] ])
		ifFalse: [ ^ self ].

	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onPharoMethodCoderCompiled: anAnnouncement [
	GtPharoMethodCoderCompiledSignal new
		mediator: self;
		announcement: anAnnouncement;
		emit.

	self connect
]

{ #category : #'private - announcement handling' }
GtPharoCommonSuiteMethodsCoderMediator >> onSuiteSelectedStateChanged: anAnnouncement [
	"Set an example/test case state filter into methods coder."

	self subclassResponsibility
]

{ #category : #'private - subscriptions' }
GtPharoCommonSuiteMethodsCoderMediator >> subscribeToMethodCoder: aMethodCoder [
	self canSubscribeToMethodCoder ifFalse: [ ^ self ].

	(aMethodCoder announcer hasSubscriber: self) ifTrue: [ ^ self ].

	"aMethodCoder weak
		when: GtCoderMethodAdded
		send: #onCoderMethodAdded:
		to: self.
	aMethodCoder weak
		when: GtCoderMethodRemoved
		send: #onCoderMethodRemoved:
		to: self."
	aMethodCoder weak
		when: GtCoderMethodModified
		send: #onCoderMethodModified:
		to: self.
	aMethodCoder weak
		when: GtPharoMethodCoderCompiled
		send: #onPharoMethodCoderCompiled:
		to: self.

	GtPharoSubscribedToMethodCoderSignal new
		methodCoder: aMethodCoder;
		mediator: self;
		emit
]

{ #category : #'private - subscriptions' }
GtPharoCommonSuiteMethodsCoderMediator >> subscriptionsStream [
	^ self methodsCoder codersStream
		relay: [ :aMethodCoder | self subscribeToMethodCoder: aMethodCoder ]
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteModel [

	^ suiteModel 
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteModel: aSuiteModel [
	self
		assert: [ suiteModel isNil ]
		description: [ 'Suite model can be initialized only once' ].

	suiteModel := aSuiteModel
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteViewModel [

	^ suiteViewModel 
]

{ #category : #accessing }
GtPharoCommonSuiteMethodsCoderMediator >> suiteViewModel: aViewModel [
	self
		assert: [ suiteViewModel isNil ]
		description: [ 'Suite view model can be initialized only once' ].
	suiteViewModel := aViewModel.

	aViewModel
		when: GtPharoSuiteSelectedStateChanged
		send: #onSuiteSelectedStateChanged:
		to: self
]

Class {
	#name : #GtPharoExampleSuiteMethodsCoderCommunicator,
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
GtPharoExampleSuiteMethodsCoderCommunicator class >> canSubscribeToMethodCoder [
	^ CanSubscribeToMethodCoder = true
]

{ #category : #'api - settings' }
GtPharoExampleSuiteMethodsCoderCommunicator class >> disableSubscribeToMethodCoder [
	CanSubscribeToMethodCoder := false
]

{ #category : #'api - settings' }
GtPharoExampleSuiteMethodsCoderCommunicator class >> enableSubscribeToMethodCoder [
	CanSubscribeToMethodCoder := true
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator class >> forMethodsCoder: aMethodsCoder suiteModel: aSuiteModel viewModel: aSuiteViewModel [
	^ self new
		methodsCoder: aMethodsCoder;
		suiteModel: aSuiteModel;
		suiteViewModel: aSuiteViewModel;
		connect
]

{ #category : #'private - updating' }
GtPharoExampleSuiteMethodsCoderCommunicator >> canSubscribeToMethodCoder [
	^ self class canSubscribeToMethodCoder
]

{ #category : #'private - updating' }
GtPharoExampleSuiteMethodsCoderCommunicator >> connect [
	| aCoderStream anExamplesStream |
	aCoderStream := self methodsCoder codersStream.
	anExamplesStream := aCoderStream
			map: [ :aMethodCoder | 
				| anExample |
				anExample := aMethodCoder example.
				self subscribeToMethodCoder: aMethodCoder.
				anExample ].

	self suiteModel stream: anExamplesStream
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator >> methodsCoder [

	^ methodsCoder
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator >> methodsCoder: aMethodsCoder [
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
GtPharoExampleSuiteMethodsCoderCommunicator >> onCoderMethodAdded: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderCommunicator >> onCoderMethodModified: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderCommunicator >> onCoderMethodRemoved: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderCommunicator >> onCodersStreamChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	((anAnnouncement isDueTo: GtStreamingCodersAddedReason)
		or: [ (anAnnouncement isDueTo: GtStreamingCodersRemovedReason)
				or: [ anAnnouncement isDueTo: GtStreamingCodersSwappedReason ] ])
		ifFalse: [ ^ self ].

	self connect
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderCommunicator >> onPharoMethodCoderCompiled: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderCommunicator >> onSuiteSelectedStateChanged: anAnnouncement [

	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	self methodsCoder additionalFilters: (GtPharoExampleStateFilter new
			 resultState: anAnnouncement state;
			 pharoExampleSuite: self suiteModel)
]

{ #category : #'private - updating' }
GtPharoExampleSuiteMethodsCoderCommunicator >> subscribeToMethodCoder: aMethodCoder [

	self canSubscribeToMethodCoder ifFalse: [ ^ self ].

	aMethodCoder weak
		when: GtCoderMethodAdded
		send: #onCoderMethodAdded:
		to: self.
	aMethodCoder weak
		when: GtCoderMethodRemoved
		send: #onCoderMethodRemoved:
		to: self.
	aMethodCoder weak
		when: GtCoderMethodModified
		send: #onCoderMethodModified:
		to: self.
	aMethodCoder weak
		when: GtPharoMethodCoderCompiled
		send: #onPharoMethodCoderCompiled:
		to: self
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator >> suiteModel [

	^ suiteModel
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator >> suiteModel: aSuiteModel [
	self
		assert: [ suiteModel isNil ]
		description: [ 'Suite model can be initialized only once' ].

	suiteModel := aSuiteModel
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator >> suiteViewModel [

	^ suiteViewModel
]

{ #category : #accessing }
GtPharoExampleSuiteMethodsCoderCommunicator >> suiteViewModel: aViewModel [
	self
		assert: [ suiteViewModel isNil ]
		description: [ 'Suite view model can be initialized only once' ].
	suiteViewModel := aViewModel.

	aViewModel
		when: GtPharoSuiteSelectedStateChanged
		send: #onSuiteSelectedStateChanged:
		to: self
]

Class {
	#name : #GtPharoTestSuiteMethodsCoderCommunicator,
	#superclass : #Object,
	#instVars : [
		'methodsCoder',
		'suiteModel',
		'suiteViewModel'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator class >> forMethodsCoder: aMethodsCoder suiteModel: aSuiteModel viewModel: aSuiteViewModel [
	^ self new
		methodsCoder: aMethodsCoder;
		suiteModel: aSuiteModel;
		suiteViewModel: aSuiteViewModel;
		connect
]

{ #category : #'private - updating' }
GtPharoTestSuiteMethodsCoderCommunicator >> connect [
	| aCoderStream aTestCaseStream |
	aCoderStream := self methodsCoder codersStream.
	aTestCaseStream := aCoderStream
			map: [ :aMethodCoder | 
				| aTestCase |
				aTestCase := aMethodCoder testCase.

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
				
				aMethodCoder compiledMethod ].

	self suiteModel stream: aTestCaseStream
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator >> methodsCoder [

	^ methodsCoder
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator >> methodsCoder: aMethodsCoder [
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
GtPharoTestSuiteMethodsCoderCommunicator >> onCoderMethodAdded: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteMethodsCoderCommunicator >> onCoderMethodModified: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteMethodsCoderCommunicator >> onCoderMethodRemoved: anAnnouncement [
	self connect
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteMethodsCoderCommunicator >> onCodersStreamChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	((anAnnouncement isDueTo: GtStreamingCodersAddedReason)
		or: [ anAnnouncement isDueTo: GtStreamingCodersRemovedReason ])
		ifFalse: [ ^ self ].

	self connect.
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteMethodsCoderCommunicator >> onSuiteSelectedStateChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	self methodsCoder
		additionalFilters: (GtPharoTestCaseStateFilter new
				resultState: anAnnouncement state;
				pharoTestSuite: self suiteModel)
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator >> suiteModel [

	^ suiteModel
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator >> suiteModel: aSuiteModel [
	self
		assert: [ suiteModel isNil ]
		description: [ 'Suite model can be initialized only once' ].

	suiteModel := aSuiteModel
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator >> suiteViewModel [

	^ suiteViewModel
]

{ #category : #accessing }
GtPharoTestSuiteMethodsCoderCommunicator >> suiteViewModel: aViewModel [
	self
		assert: [ suiteViewModel isNil ]
		description: [ 'Suite view model can be initialized only once' ].
	suiteViewModel := aViewModel.

	aViewModel
		when: GtPharoSuiteSelectedStateChanged
		send: #onSuiteSelectedStateChanged:
		to: self
]

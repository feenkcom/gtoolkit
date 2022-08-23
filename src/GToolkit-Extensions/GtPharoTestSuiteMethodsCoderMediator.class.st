Class {
	#name : #GtPharoTestSuiteMethodsCoderMediator,
	#superclass : #GtPharoCommonSuiteMethodsCoderMediator,
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #'private - streaming' }
GtPharoTestSuiteMethodsCoderMediator >> connect [
	| aTestCaseStream |
	aTestCaseStream := self testCasesStream.

	GtPharoNewCodersStreamSignal new
		mediator: self;
		stream: aTestCaseStream;
		emit.

	self suiteModel stream: aTestCaseStream
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteMethodsCoderMediator >> onSuiteSelectedStateChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	self methodsCoder
		additionalFilters: (GtPharoTestCaseStateFilter new
				resultState: anAnnouncement state;
				pharoTestSuite: self suiteModel)
]

{ #category : #'private - streaming' }
GtPharoTestSuiteMethodsCoderMediator >> testCasesStream [
	^ (self subscriptionsStream
		map: [ :aMethodCoder | aMethodCoder compiledMethod ]) 
		filter: [ :aMethod | aMethod isNotNil ]
]

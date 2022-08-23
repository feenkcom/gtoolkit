Class {
	#name : #GtPharoExampleSuiteMethodsCoderMediator,
	#superclass : #GtPharoCommonSuiteMethodsCoderMediator,
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #'private - streaming' }
GtPharoExampleSuiteMethodsCoderMediator >> connect [
	| anExamplesStream |
	anExamplesStream := self examplesStream.

	GtPharoNewCodersStreamSignal new
		mediator: self;
		stream: anExamplesStream;
		emit.

	self suiteModel stream: anExamplesStream
]

{ #category : #'private - streaming' }
GtPharoExampleSuiteMethodsCoderMediator >> examplesStream [
	^ (self subscriptionsStream
		map: [ :aMethodCoder | aMethodCoder example ])
		filter: [ :anExample | anExample isNotNil ]
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteMethodsCoderMediator >> onSuiteSelectedStateChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	GtPharoMethodCoderAnnouncementSignal new
		mediator: self;
		announcement: anAnnouncement;
		emit.

	self methodsCoder
		additionalFilters: (GtPharoExampleStateFilter new
				resultState: anAnnouncement state;
				pharoExampleSuite: self suiteModel)
]

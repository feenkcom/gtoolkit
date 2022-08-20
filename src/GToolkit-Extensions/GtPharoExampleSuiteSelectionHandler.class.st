Class {
	#name : #GtPharoExampleSuiteSelectionHandler,
	#superclass : #Object,
	#instVars : [
		'methodsCoder',
		'suiteModel'
	],
	#category : #'GToolkit-Extensions'
}

{ #category : #accessing }
GtPharoExampleSuiteSelectionHandler >> methodsCoder [

	^ methodsCoder
]

{ #category : #accessing }
GtPharoExampleSuiteSelectionHandler >> methodsCoder: anObject [

	methodsCoder := anObject
]

{ #category : #'api - announcement handling' }
GtPharoExampleSuiteSelectionHandler >> onAnnouncement: anAnnouncement [
	self onSuiteSelectedStateChanged: anAnnouncement
]

{ #category : #'api - announcement handling' }
GtPharoExampleSuiteSelectionHandler >> onCodersStreamChanged: anAnnouncement [
	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	((anAnnouncement isDueTo: GtStreamingCodersAddedReason)
		or: [ anAnnouncement isDueTo: GtStreamingCodersRemovedReason ])
		ifFalse: [ ^ self ].

	self suiteModel streamChangedTo: self methodsCoder examplesStream
]

{ #category : #'api - announcement handling' }
GtPharoExampleSuiteSelectionHandler >> onSuiteSelectedStateChanged: anAnnouncement [

	self methodsCoder ifNil: [ ^ self ].
	self suiteModel ifNil: [ ^ self ].

	self methodsCoder additionalFilters: (GtPharoExampleStateFilter new
			 resultState: anAnnouncement state;
			 pharoExampleSuite: self suiteModel)
]

{ #category : #accessing }
GtPharoExampleSuiteSelectionHandler >> suiteModel [

	^ suiteModel
]

{ #category : #accessing }
GtPharoExampleSuiteSelectionHandler >> suiteModel: anObject [

	suiteModel := anObject
]

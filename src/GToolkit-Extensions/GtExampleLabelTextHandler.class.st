Class {
	#name : #GtExampleLabelTextHandler,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtExampleLabelTextHandler >> element [

	^ element
]

{ #category : #accessing }
GtExampleLabelTextHandler >> element: anObject [

	element := anObject
]

{ #category : #'api - announcement handling' }
GtExampleLabelTextHandler >> onAnnouncement: anAnnouncement [
	| anElement aText |
	anElement := self element.
	anElement ifNil: [ ^ self ].
	aText := anAnnouncement example resultOrErrorName asRopedText.

	anElement enqueueTask: (BlTaskAction new action: [ anElement text: aText ])
]

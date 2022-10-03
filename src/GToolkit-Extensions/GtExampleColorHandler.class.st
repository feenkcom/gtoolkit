Class {
	#name : #GtExampleColorHandler,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Extensions-Examples'
}

{ #category : #accessing }
GtExampleColorHandler >> element [

	^ element
]

{ #category : #accessing }
GtExampleColorHandler >> element: anObject [

	element := anObject
]

{ #category : #'api - announcement handling' }
GtExampleColorHandler >> onAnnouncement: anAnnouncement [
	| anElement aColor |
	anElement := self element.
	anElement ifNil: [ ^ self ].
	aColor := anAnnouncement result color.

	anElement
		enqueueTask: (BlTaskAction new action: [ anElement background: aColor ])
]

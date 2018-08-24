"
I am a transcript that can handle both strings and adornments.

!Example

[[[
transcript := GTOTranscript new.
element := transcript newEditorElement.
transcript nextPutAll: 'test
asdasda'.
transcript nextPutAll: 'enhanced' with: [ BrTextAdornmentDynamicAttribute new beAppend; adornmentBlock: [ BlElement new size: 70 @ 50; background: Color red; yourself  ]].
transcript nextPutAll: 'test'.
element
]]]
"
Class {
	#name : #GtTranscript,
	#superclass : #Object,
	#instVars : [
		'text',
		'editor'
	],
	#category : 'GToolkit-Transcript'
}

{ #category : #streaming }
GtTranscript >> << anObject [
	self show: anObject
]

{ #category : #streaming }
GtTranscript >> clear [ 
	self flag: 'todo'.
	self notYetImplemented
]

{ #category : #streaming }
GtTranscript >> cr [
	self next cr
]

{ #category : #accessing }
GtTranscript >> editor [
	^ editor
]

{ #category : #accessing }
GtTranscript >> editor: anObject [
	editor := anObject
]

{ #category : #ui }
GtTranscript >> gtInspectorLiveIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ self newEditorElement gtInspectorLiveIn: composite
]

{ #category : #'gt-extension' }
GtTranscript >> gtLiveFor: aView [
	<gtView: 0>
	^ self newEditorElement gtLiveFor: aView
]

{ #category : #initialization }
GtTranscript >> initialize [
	text := '' asRopedText.
	editor := BrTextEditor new.
	editor text: text
]

{ #category : #ui }
GtTranscript >> newEditorElement [
	| transcriptElement |
	transcriptElement := GtTranscriptElement new
		transcript: self.
	transcriptElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ transcriptElement
]

{ #category : #streaming }
GtTranscript >> next [
	"This is a utility method for enabling a fluent API"
	^ GtTranscriptNextBuilder new transcript: self 
]

{ #category : #streaming }
GtTranscript >> nextPut: aCharacter [
	self next put: aCharacter
]

{ #category : #streaming }
GtTranscript >> nextPutAll: aString [
	self next putAll: aString
]

{ #category : #ui }
GtTranscript >> open [
	| space |
	space := BlSpace new.
	space extent: 600@400.
	space root addChild: self newEditorElement.
	space show
]

{ #category : #streaming }
GtTranscript >> print: anObject [
	self next print: anObject
]

{ #category : #streaming }
GtTranscript >> show: anObject [
	self print: anObject
]

{ #category : #streaming }
GtTranscript >> showException: anException [
	self next showException: anException.
	self cr
]

{ #category : #streaming }
GtTranscript >> space [
	self next space
]

{ #category : #streaming }
GtTranscript >> tab [
	self next tab
]

{ #category : #accessing }
GtTranscript >> text [
	^ text
]

{ #category : #accessing }
GtTranscript >> text: anObject [
	text := anObject
]

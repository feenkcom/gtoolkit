"
I am a transcript that can handle both strings and adornments.

!!Examples

See ${class:GtTranscriptExamples}$.
"
Class {
	#name : #GtTranscript,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'text',
		'announcer'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #accessing }
GtTranscript class >> cleanUp [
	super cleanUp.
	
	default := nil
]

{ #category : #accessing }
GtTranscript class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #actions }
GtTranscript class >> installDefault [
	Smalltalk globals at: #Transcript put: self default.
]

{ #category : #streaming }
GtTranscript >> << anObject [
	self show: anObject
]

{ #category : #accessing }
GtTranscript >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #ui }
GtTranscript >> asElement [
	^ GtTranscriptElement new transcript: self
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

{ #category : #'gt-extension' }
GtTranscript >> gtLiveFor: aView [
	<gtView>

	^ self asElement gtLiveFor: aView
]

{ #category : #initialization }
GtTranscript >> initialize [
	announcer := Announcer new.
	text := '' asRopedText.

	mutex := Mutex new
]

{ #category : #'private - actions' }
GtTranscript >> insertString: aString withAttributes: aCollection [
	self textDo: [ :aText |
		aText append: (aString asRopedText attributes: aCollection).
		self announcer announce: (GtTranscriptInsertStringAnnouncement new 
			string: aString; 
			attributes: aCollection) ]
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
	| aSpace |
	aSpace := BlSpace new.
	aSpace extent: 600@400.
	aSpace title: 'Transcript'.
	aSpace addChild: self asElement.
	aSpace show
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

{ #category : #accessing }
GtTranscript >> stepGlobal [
	"do nothing. it's here for compatibility with the old Transcript"
]

{ #category : #streaming }
GtTranscript >> tab [
	self next tab
]

{ #category : #accessing }
GtTranscript >> textDo: aBlock [
	<return: #BlText>

	^ mutex critical: [ aBlock value: text ]
]

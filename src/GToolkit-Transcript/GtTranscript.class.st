"
I am a transcript that can handle both strings and adornments.

## Examples

See {{gtClass:GtTranscriptExamples}}.

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

{ #category : #accessing }
GtTranscript class >> streamContents: aBlock [
	| temp |
	temp := self new.
	aBlock value: temp.
	^ temp textDo: #yourself
]

{ #category : #'api - streaming' }
GtTranscript >> << anObject [
	self show: anObject
]

{ #category : #'api - accessing' }
GtTranscript >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'api - ui' }
GtTranscript >> asElement [
	^ GtTranscriptElement new transcript: self
]

{ #category : #'api - streaming' }
GtTranscript >> clear [ 
	self textDo: [ :aText | 
		aText deleteAll.
		self announcer announce: GtTranscriptDeleteAllAnnouncement ]
]

{ #category : #'api - streaming' }
GtTranscript >> cr [
	self next cr
]

{ #category : #'api - streaming' }
GtTranscript >> crShow: anObject [
	self 
		cr; 
		show: anObject
]

{ #category : #compatibility }
GtTranscript >> endEntry [
	"do nothing. it's here for compatibility with the old Transcript"
]

{ #category : #compatibility }
GtTranscript >> flush [
	"do nothing. it's here for compatibility with the old Transcript"
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

{ #category : #translation }
GtTranscript >> newLine [
	self cr
]

{ #category : #'api - streaming' }
GtTranscript >> next [
	"This is a utility method for enabling a fluent API"
	^ GtTranscriptNextBuilder new transcript: self 
]

{ #category : #'api - streaming' }
GtTranscript >> nextPut: aCharacter [
	self next put: aCharacter
]

{ #category : #'api - streaming' }
GtTranscript >> nextPutAll: aString [
	self next putAll: aString
]

{ #category : #'api - ui' }
GtTranscript >> open [
	| aSpace |
	aSpace := BlSpace new.
	aSpace extent: 600@400.
	aSpace title: 'Transcript'.
	aSpace addChild: self asElement.
	aSpace show
]

{ #category : #'api - streaming' }
GtTranscript >> print: anObject [
	self next print: anObject
]

{ #category : #'api - streaming' }
GtTranscript >> show: anObject [
	self print: anObject
]

{ #category : #'api - streaming' }
GtTranscript >> showException: anException [
	self next showException: anException.
	self cr
]

{ #category : #'api - streaming' }
GtTranscript >> space [
	self next space
]

{ #category : #compatibility }
GtTranscript >> stepGlobal [
	"do nothing. it's here for compatibility with the old Transcript"
]

{ #category : #'api - streaming' }
GtTranscript >> tab [
	self next tab
]

{ #category : #'api - accessing' }
GtTranscript >> textDo: aBlock [
	<return: #BlText>

	^ mutex critical: [ [ aBlock value: text] on: Error do: [ :anError |
			anError emit.

			NonInteractiveTranscript stderr
				print: anError;
				cr ] ]
]

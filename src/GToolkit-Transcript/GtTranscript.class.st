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
		'editor',
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

{ #category : #streaming }
GtTranscript >> << anObject [
	self show: anObject
]

{ #category : #'announcement handling' }
GtTranscript >> announceInsertString: aString withAttributes: attributes [
	self announcer numberOfSubscriptions isZero ifTrue: [ 
		self insertString: aString withAttributes: attributes ].
	self announcer announce: (GtTranscriptInsertStringAnnouncement new 
		editor: self editor;
		text: self text;
		string: aString; 
		attributes: attributes)
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
	^ self asElement gtInspectorLiveIn: composite
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
	editor := BrTextEditor new.
	editor text: text
]

{ #category : #'private - actions' }
GtTranscript >> insertString: aString withAttributes: aCollection [ 
	GtTranscriptInsertStringCommand new
		string: aString;
		attributes: aCollection;
		text: self text;
		editor: self editor;
		execute.
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
	space root addChild: self asElement.
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

{ #category : #accessing }
GtTranscript >> stepGlobal [
	"do nothing. it's here for compatibility with the old Transcript"
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

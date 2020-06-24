"
I am a transcript element with support of auto scroll

!! Example

[[[
	| transcript transcriptElement |
	
	transcript := GtTranscript new.
	transcriptElement := GtTranscriptElement new.
	transcriptElement transcript: transcript
]]]
"
Class {
	#name : #GtTranscriptElement,
	#superclass : #BlElement,
	#instVars : [
		'editorElement',
		'transcript',
		'scrollButtonElement',
		'isAutoScrollEnabled'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #initialization }
GtTranscriptElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #scrolling }
GtTranscriptElement >> disableAutoScroll [
	self setAutoScroll: false
]

{ #category : #scrolling }
GtTranscriptElement >> enableAutoScroll [
	self setAutoScroll: true
]

{ #category : #initialization }
GtTranscriptElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c padding: (BlInsets all: 10).
		c horizontal matchParent.
		c vertical matchParent ].

	isAutoScrollEnabled := true.

	self initializeElements.
	self initializeListeners
]

{ #category : #initialization }
GtTranscriptElement >> initializeElements [
	editorElement := self newEditorElement.
	editorElement matchParent.
	
	editorElement editor
		when: BrTextEditorInsertedEvent
		do: [ self updateScroll ].

	scrollButtonElement := self newScrollButtonElement.
	scrollButtonElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c padding: (BlInsets all: 10) ].
	self updateScrollButton.
	
	self addChildren: { editorElement . scrollButtonElement }
]

{ #category : #initialization }
GtTranscriptElement >> initializeListeners [
	scrollButtonElement addEventHandlerOn: BlClickEvent do: [ :anEvent |
		self isAutoScrollEnabled
			ifTrue: [ self disableAutoScroll ]
			ifFalse: [ self enableAutoScroll ].
		anEvent consumed: true ].
	
	editorElement
		addEventHandlerOn: BlElementScrolledEvent
		do: [ :anEvent |
			anEvent delta y isZero not
				ifTrue: [ self isAutoScrollEnabled ifTrue: [ self disableAutoScroll ] ] ]
]

{ #category : #'announcement handling' }
GtTranscriptElement >> insertStringAnnouncement: aGtTranscriptInsertStringAnnouncement [
	editorElement enqueueTask: (GtTranscriptInsertStringTaskAction new
		announcement: aGtTranscriptInsertStringAnnouncement;
		editor: editorElement editor;
		string: aGtTranscriptInsertStringAnnouncement string;
		attributes: aGtTranscriptInsertStringAnnouncement attributes)
]

{ #category : #testing }
GtTranscriptElement >> isAutoScrollEnabled [
	^ isAutoScrollEnabled
]

{ #category : #'instance creation' }
GtTranscriptElement >> newEditorElement [
	^ BrEditor new
		look: BrGlamorousCodeEditorLook new
]

{ #category : #'instance creation' }
GtTranscriptElement >> newScrollButtonElement [
	^ BlElement new
		geometry: BlEllipse new;
		size: 10@10;
		background: Color white;
		yourself
]

{ #category : #'hooks - children' }
GtTranscriptElement >> onAddedToSceneGraph [
	| aTranscript |
	super onAddedToSceneGraph.

	aTranscript := self transcript
		ifNil: [ ^ self ].

	aTranscript textDo: [ :aText |
		editorElement text: aText copy.
	
		aTranscript announcer
			when: GtTranscriptInsertStringAnnouncement
			send: #insertStringAnnouncement:
			to: self ].

	self updateScroll
]

{ #category : #'hooks - children' }
GtTranscriptElement >> onRemovedFromSceneGraph [
	| aTranscript |
	super onRemovedFromSceneGraph.

	aTranscript := self transcript
		ifNil: [ ^ self ].

	aTranscript announcer unsubscribe: self
]

{ #category : #accessing }
GtTranscriptElement >> setAutoScroll: aBoolean [

	isAutoScrollEnabled := aBoolean.
	self updateScrollButton.
	self updateScroll
]

{ #category : #accessing }
GtTranscriptElement >> transcript [
	<return: #GtTranscript>
	
	^ transcript
]

{ #category : #accessing }
GtTranscriptElement >> transcript: aGtTranscript [
	transcript := aGtTranscript
]

{ #category : #updating }
GtTranscriptElement >> updateScroll [
	self isAutoScrollEnabled
		ifTrue: [ editorElement scrollToLast ]
]

{ #category : #updating }
GtTranscriptElement >> updateScrollButton [

	self isAutoScrollEnabled
		ifTrue: [ scrollButtonElement border: (BlBorder builder width: 5; paint: Color green twiceDarker; build) ]
		ifFalse: [ scrollButtonElement border: (BlBorder builder width: 5; paint: Color lightGray; build) ]
]

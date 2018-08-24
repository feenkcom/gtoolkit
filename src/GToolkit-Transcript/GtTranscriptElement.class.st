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
	#category : 'GToolkit-Transcript'
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
	
	isAutoScrollEnabled := true.
	self initializeElements.
	self initializeListeners
]

{ #category : #initialization }
GtTranscriptElement >> initializeElements [
	editorElement := self newEditorElement.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

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

{ #category : #testing }
GtTranscriptElement >> isAutoScrollEnabled [
	^ isAutoScrollEnabled
]

{ #category : #'instance creation' }
GtTranscriptElement >> newEditorElement [
	^ BrEditorElement new
]

{ #category : #'instance creation' }
GtTranscriptElement >> newScrollButtonElement [
	^ BlElement new
		geometry: BlEllipse new;
		size: 10@10;
		background: Color white;
		yourself
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
	transcript := aGtTranscript.
	
	editorElement editor: transcript editor.

	transcript editor
		addEventFilterOn: BrTextEditorInsertedEvent
		do: [ self updateScroll ].

	self updateScroll
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

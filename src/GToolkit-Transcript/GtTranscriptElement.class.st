"
I am a transcript element with support of auto scroll

## Example

```
	| transcript transcriptElement |
	
	transcript := GtTranscript new.
	transcriptElement := GtTranscriptElement new.
	transcriptElement transcript: transcript
```

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

{ #category : #'private - actions' }
GtTranscriptElement >> clear [
	self transcriptDo: [ :aTranscript | aTranscript clear ]
]

{ #category : #initialization }
GtTranscriptElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'announcement handling' }
GtTranscriptElement >> deleteAllAnnouncement: aGtTranscriptDeleteAllAnnouncement [
	editorElement enqueueTask: (GtTranscriptDeleteAllTaskAction new
		editor: editorElement editor)
]

{ #category : #'private - scrolling' }
GtTranscriptElement >> disableAutoScroll [
	self setAutoScroll: false
]

{ #category : #'private - scrolling' }
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
	| clearButtonElement toolbarElement |
	editorElement := self newEditorElement.
	editorElement constraintsDo: [:c | c vertical matchParent. c horizontal matchParent].
	
	editorElement editor
		when: BrTextEditorInsertedEvent
		do: [ self updateScroll ].

	scrollButtonElement := self newScrollButtonElement.
	clearButtonElement := self newClearButtonElement.
	toolbarElement := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 5; alignCenter);
		addChild: clearButtonElement;
		addChild: scrollButtonElement;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c frame horizontal alignRight.
			c padding: (BlInsets all: 10) ].
	self updateScrollButton.
	
	self addChildren: { editorElement . toolbarElement }
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
		editor: editorElement editor;
		string: aGtTranscriptInsertStringAnnouncement string;
		attributes: aGtTranscriptInsertStringAnnouncement attributes)
]

{ #category : #'private - scrolling' }
GtTranscriptElement >> isAutoScrollEnabled [
	^ isAutoScrollEnabled
]

{ #category : #'private - instance creation' }
GtTranscriptElement >> newClearButtonElement [
	^ BrButton new
		aptitude: BrIconAptitude + BrGlamorousButtonWithLabelTooltipAptitude2;
		icon: BrGlamorousVectorIcons bin;
		label: 'Clear Transcript';
		size: 16 @ 16;
		action: [ self clear ]
]

{ #category : #'private - instance creation' }
GtTranscriptElement >> newEditorElement [
	^ BrEditorElement new
		editor: BrTextEditorModel new
		"look: BrGlamorousCodeEditorLook new"
]

{ #category : #'private - instance creation' }
GtTranscriptElement >> newScrollButtonElement [
	^ BlElement new
		aptitude: (BrGlamorousWithExplicitTooltipAptitude
				text: 'Enable/Disable Automatic Transcript Scrolling');
		geometry: BlEllipseGeometry new;
		size: 10 @ 10;
		background: Color white
]

{ #category : #'hooks - children' }
GtTranscriptElement >> onAddedToSceneGraph [
	| aTranscript |
	super onAddedToSceneGraph.

	self unsubscribeFromTranscript.
	
	aTranscript := self transcript
		ifNil: [ ^ self ].

	aTranscript textDo: [ :aText |
		editorElement editor text: aText copy.
	
		aTranscript announcer
			when: GtTranscriptInsertStringAnnouncement
			send: #insertStringAnnouncement:
			to: self.
			
		aTranscript announcer
			when: GtTranscriptDeleteAllAnnouncement
			send: #deleteAllAnnouncement:
			to: self ].

	self updateScroll
]

{ #category : #'hooks - children' }
GtTranscriptElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	self unsubscribeFromTranscript.
]

{ #category : #'private - scrolling' }
GtTranscriptElement >> setAutoScroll: aBoolean [

	isAutoScrollEnabled := aBoolean.
	self updateScrollButton.
	self updateScroll
]

{ #category : #'private - accessing' }
GtTranscriptElement >> transcript [
	<return: #GtTranscript>
	
	^ transcript
]

{ #category : #'api - accessing' }
GtTranscriptElement >> transcript: aGtTranscript [
	self 
		assert: [ aGtTranscript isNotNil ] 
		description: [ 'Transcript must be non-nil' ].
	self 
		assert: [ transcript isNil ] 
		description: [ 'You can attach to a transcript only once' ].
	transcript := aGtTranscript.
]

{ #category : #'private - accessing' }
GtTranscriptElement >> transcriptDo: aBlock [
	self transcript ifNotNil: aBlock
]

{ #category : #'private - subscriptions' }
GtTranscriptElement >> unsubscribeFromTranscript [
	self transcriptDo: [ :aTranscript |
		aTranscript announcer unsubscribe: self ]
]

{ #category : #updating }
GtTranscriptElement >> updateScroll [
	self isAutoScrollEnabled
		ifTrue: [ editorElement scrollToLast ]
]

{ #category : #updating }
GtTranscriptElement >> updateScrollButton [

	self isAutoScrollEnabled
		ifTrue: [ 
			scrollButtonElement border: (BlBorder builder width: 5; paint: Color green twiceDarker; build).
			scrollButtonElement aptitude text: 'Disable Automatic Transcript Scrolling' ]
		ifFalse: [ 
			scrollButtonElement border: (BlBorder builder width: 5; paint: Color lightGray; build).
			scrollButtonElement aptitude text: 'Enable Automatic Transcript Scrolling' ]
]

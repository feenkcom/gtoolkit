Class {
	#name : #GtToolsMenu,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'knowledgeBase'
	],
	#classInstVars : [
		'world'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #'system startup' }
GtToolsMenu class >> cleanUp [
	<script: 'self cleanUp'>

	world ifNotNil: [
		world isOpened
			ifTrue: [ world close ].
		world := nil ]
]

{ #category : #'instance creation' }
GtToolsMenu class >> create [
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace addChild: self new.
	aSpace extent: 260@500.
	^ aSpace
]

{ #category : #'instance creation' }
GtToolsMenu class >> open [
	<script: 'self open'>

	(world isNotNil and: [ world isOpened ])
		ifTrue: [ world close ].

	world := self create.

	world isOpened
		ifFalse: [ world show ]
]

{ #category : #'api - tools' }
GtToolsMenu class >> openPlaygroundFrom: anElement [
	  GtPlayground openFrom: anElement
]

{ #category : #initialization }
GtToolsMenu >> iconSize [
	^ 75 asPoint
]

{ #category : #initialization }
GtToolsMenu >> initialize [
	super initialize.
	
	self layout: BlFlowLayout new.
	self hMatchParent.
	self vFitContent.
	self padding: (BlInsets all: 10).
	self initializeElements
]

{ #category : #initialization }
GtToolsMenu >> initializeElements [

	self removeChildren.

	self addChild: ((GtHomeToolsSection new knowledgeBaseComputation: [ self knowledgeBase ])
		newPlaygroundButtonStencil smallIcon smallMargin create size: self iconSize).
	
	GtImage isLepiterEnabled ifTrue: [ 
		self addChild: ((GtHomeToolsSection new knowledgeBaseComputation: [ self knowledgeBase ])
			newNotesButtonStencil smallIcon smallMargin create size: self iconSize).
		self addChild: ((GtHomeToolsSection new knowledgeBaseComputation: [ self knowledgeBase ]) 
			newLepiterButtonStencil smallIcon smallMargin create size: self iconSize) ].
	
	self addChild: (GtHomeToolsSection new newCoderButtonStencil smallIcon smallMargin create size: self iconSize).
	self addChild: (GtHomeToolsSection new newGitButtonStencil smallIcon smallMargin create size: self iconSize).
	self addChild: (GtHomeToolsSection new newMonitorButtonStencil smallIcon smallMargin create size: self iconSize).
	self addChild: (GtHomeToolsSection new newExamplesButtonStencil smallIcon smallMargin create size: self iconSize).
	self addChild: (GtHomeToolsSection new newTranscriptButtonStencil smallIcon smallMargin create size: self iconSize).
	self addChild: (GtHomeToolsSection new newFileSystemButtonStencil smallIcon smallMargin create size: self iconSize).
	self addChild: (GtHomeToolsSection new newMorphicWorldButtonStencil smallIcon smallMargin create size: self iconSize).
		
	self addChild: (BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		margin: (BlInsets top: 25 left: 0 bottom: 5 right: 0);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: {
			BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Save';
				hMatchParent;
				action: [ :aButton | self saveFrom: aButton ].
				
			BrButton new
				aptitude: (BrGlamorousButtonWithLabelAptitude new);
				label: 'Quit';
				hMatchParent;
				action: [ :aButton | self quitFrom: aButton ] })
]

{ #category : #accessing }
GtToolsMenu >> knowledgeBase [
	^ knowledgeBase
]

{ #category : #accessing }
GtToolsMenu >> knowledgeBase: aKnowledgeBase [
	knowledgeBase := aKnowledgeBase
]

{ #category : #'hooks - children' }
GtToolsMenu >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self initializeElements
]

{ #category : #'private - actions' }
GtToolsMenu >> quitFrom: aButton [
	aButton label: 'Quitting...'.
	aButton disable.
	aButton space universe snapshot: false andQuit: true.
	aButton space universe postpone: [
		aButton enqueueTask: (BlTaskAction new action: [
			aButton label: 'Quit'; enable ]) ].
]

{ #category : #'private - actions' }
GtToolsMenu >> saveFrom: aButton [
	aButton label: 'Saving...'.
	aButton disable.
	aButton space universe snapshot: true andQuit: false.
	aButton space universe postpone: [
		aButton enqueueTask: (BlTaskAction new action: [
			aButton label: 'Save'; enable ]) ].
]

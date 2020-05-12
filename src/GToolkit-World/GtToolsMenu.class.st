Class {
	#name : #GtToolsMenu,
	#superclass : #BlElement,
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
GtToolsMenu >> initialize [
	super initialize.
	
	self layout: BlFlowLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self padding: (BlInsets top: 10 bottom: 10).
	self initializeElements
]

{ #category : #initialization }
GtToolsMenu >> initializeElements [

	self removeChildren.

	self addChild: (GtHomeToolsSection new newPlaygroundButtonStencil smallIcon create size: 100@100).
	self addChild: (GtHomeToolsSection new newCoderButtonStencil smallIcon create  size: 100@100).
	self addChild: (GtHomeToolsSection new newGitButtonStencil smallIcon create  size: 100@100).
	self addChild: (GtHomeToolsSection new newMonitorButtonStencil smallIcon create  size: 100@100).
	self addChild: (GtHomeToolsSection new newExamplesButtonStencil smallIcon create  size: 100@100).
	self addChild: (GtHomeToolsSection new newTranscriptButtonStencil smallIcon create  size: 100@100).
	self addChild: (GtHomeToolsSection new newMorphicWorldButtonStencil smallIcon create  size: 100@100).
		
	self addChild: (BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		margin: (BlInsets top: 25 left: 10 bottom: 5 right: 10);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: {
			BrButton new
				look: BrGlamorousButtonWithLabelLook new;
				label: 'Save';
				hMatchParent;
				action: [ :aButton | aButton space universe snapshot: true andQuit: false ].
				
			BrButton new
				look: (BrGlamorousButtonWithLabelLook new);
				label: 'Quit';
				hMatchParent;
				action: [ :aButton | aButton space universe snapshot: false andQuit: true ] })
]

{ #category : #'hooks - children' }
GtToolsMenu >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self initializeElements
]

Class {
	#name : #GtNotificationEmptyElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'labelElement'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #initialization }
GtNotificationEmptyElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtNotificationEmptyElement >> initialize [
	super initialize.
	self initializeTextEditor.

	self margin: (BlInsets all: 10).
	self padding: (BlInsets all: 10).
	
	self addChild: self labelElement as: #labelElement.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		anyToFitContent: self labelElement).
]

{ #category : #initialization }
GtNotificationEmptyElement >> initializeTextEditor [
	labelElement := BrLabel new
		look: (BrGlamorousLabelLook new
			foreground: BrGlamorousColors disabledButtonTextColor);
		text: 'without notifications';
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]

{ #category : #accessing }
GtNotificationEmptyElement >> labelElement [
	<return: #BrLabel>
	^ labelElement
]

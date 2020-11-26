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
	self initializeLabel.

	self margin: (BlInsets all: 10).
	self padding: (BlInsets all: 10).
	
	self addChild: self labelElement as: #labelElement.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		anyToFitContent: self labelElement).
]

{ #category : #initialization }
GtNotificationEmptyElement >> initializeLabel [
	labelElement := BrLabel new
		look: (BrGlamorousLabelLook new
			foreground: BrGlamorousColors disabledButtonTextColor);
		text: 'no notifications';
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]

{ #category : #accessing }
GtNotificationEmptyElement >> labelElement [
	<return: #BrLabel>
	^ labelElement
]

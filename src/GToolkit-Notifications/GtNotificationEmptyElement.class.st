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
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent;
		anyToFitContent: self labelElement).
]

{ #category : #initialization }
GtNotificationEmptyElement >> initializeLabel [
	labelElement := BrLabel new
		aptitude:
			(BrGlamorousLabelAptitude new
				foreground: self theme button disabledTextColor);
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

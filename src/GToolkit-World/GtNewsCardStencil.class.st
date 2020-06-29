Class {
	#name : #GtNewsCardStencil,
	#superclass : #BrStencil,
	#instVars : [
		'headerText',
		'actionText',
		'tooltipText',
		'action'
	],
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsCardStencil >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GtNewsCardStencil >> actionText: anObject [
	actionText := anObject
]

{ #category : #'api - instantiation' }
GtNewsCardStencil >> create [
	| container actionButton headerLabel |
	container := BlElement new
		background: BrGlamorousColors newsBackgroundColor;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets top: 10 left: 30 bottom: 10 right: 10).
	
	headerLabel := BrLabel new 
		fitContent;
		look: (BrGlamorousLabelLook new);
		constraintsDo: [ :c |
			c linear vertical alignCenter ];
		text: headerText.

	actionButton := BrButton new
		label: actionText;
		look: BrGlamorousButtonWithLabelLook new;
		border: (BlBorder paint: Color black);
		padding: (BlInsets left: 10 right: 10);
		margin: (BlInsets top: 0 left: 15 bottom: 0 right: 0);
		constraintsDo: [ :c |
			c linear vertical alignCenter ];
		action: action.
	
	container
		addChild: headerLabel;
		addChild: actionButton.
	^ container
]

{ #category : #accessing }
GtNewsCardStencil >> headerText: anObject [
	headerText := anObject
]

{ #category : #accessing }
GtNewsCardStencil >> tooltipText: anObject [
	tooltipText := anObject
]

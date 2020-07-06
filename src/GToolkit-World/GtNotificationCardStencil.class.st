Class {
	#name : #GtNotificationCardStencil,
	#superclass : #BrStencil,
	#instVars : [
		'headerText',
		'actionText',
		'tooltipText',
		'openAction',
		'closeAction'
	],
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotificationCardStencil >> actionText: anObject [
	actionText := anObject
]

{ #category : #accessing }
GtNotificationCardStencil >> closeAction: aBlock [
	closeAction := aBlock
]

{ #category : #'api - instantiation' }
GtNotificationCardStencil >> create [
	| container actionButton headerLabel closeButton |
	container := BlElement new
		clipChildren: false;
		background: BrGlamorousColors newsBackgroundColor;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		look: BrShadowLook;
		margin: (BlInsets top: 10+5 left: 30 bottom: 10 right: 30);
		padding: (BlInsets top: 10 left: 10 bottom: 10 right: 10).
	
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
		action: openAction.
	closeButton := GtHomeCloseButtonStencil new 
		closeAction: closeAction;
		create.
	
	container
		addChild: headerLabel;
		addChild: actionButton;
		addChild: closeButton.
	^ container
]

{ #category : #accessing }
GtNotificationCardStencil >> headerText: anObject [
	headerText := anObject
]

{ #category : #accessing }
GtNotificationCardStencil >> openAction: anObject [
	openAction := anObject
]

{ #category : #accessing }
GtNotificationCardStencil >> tooltipText: anObject [
	tooltipText := anObject
]

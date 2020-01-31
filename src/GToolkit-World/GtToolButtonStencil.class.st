Class {
	#name : #GtToolButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'icon',
		'title',
		'description',
		'action',
		'iconSize'
	],
	#category : #'GToolkit-World'
}

{ #category : #accessing }
GtToolButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtToolButtonStencil >> action: anObject [
	action := anObject
]

{ #category : #'api - instantiation' }
GtToolButtonStencil >> create [
	<return: #BrButton>

	| iconElement labelElement |
	iconElement := self icon asScalableElement size: self iconSize; margin: (BlInsets bottom: 5).
	labelElement := BrLabel new 
	    text: self title;
	    look: (BrGlamorousLabelLook new fontSize: 14).
	^ BrButton new
		constraintsDo:[ :c | 
	        c horizontal exact: 120.
	        c vertical exact: 120 ];
		margin: (BlInsets top: 10 left: 20 bottom: 10 right: 20);
		action: self action;
		padding: (BlInsets all: 10);
		label: self description;
		look: (BrGlamorousButtonExteriorLook new + BrGlamorousWithLabelTooltipLook new);
		geometry: (BlRectangle cornerRadius: 4);
		layout: BlLinearLayout vertical alignCenter;
		addChild: iconElement;
		addChild: labelElement.
]

{ #category : #accessing }
GtToolButtonStencil >> description [
	^ description
]

{ #category : #accessing }
GtToolButtonStencil >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> icon [
	^ icon
]

{ #category : #accessing }
GtToolButtonStencil >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtToolButtonStencil >> iconSize [
	^ iconSize
]

{ #category : #accessing }
GtToolButtonStencil >> iconSize: aPoint [
	iconSize := aPoint
]

{ #category : #initialization }
GtToolButtonStencil >> initialize [
	super initialize.
	description := 'Some tool'.
	title := 'Some tool'.
	action := [  ].
	iconSize := 64@64.
	icon := BlElement new size: iconSize.
]

{ #category : #accessing }
GtToolButtonStencil >> smallIcon [
	self iconSize: 32@32
]

{ #category : #accessing }
GtToolButtonStencil >> title [
	^ title
]

{ #category : #accessing }
GtToolButtonStencil >> title: anObject [
	title := anObject
]

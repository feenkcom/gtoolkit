Class {
	#name : #GtNotificationDecoratingEventElement,
	#superclass : #GtNotificationElement,
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #initialization }
GtNotificationDecoratingEventElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #defaults }
GtNotificationDecoratingEventElement >> defaultVercialResizerModel [
	^ BrLayoutVerticalResizerModel fitContent
]

{ #category : #'private - accessing' }
GtNotificationDecoratingEventElement >> element [
	^ self childAt: 1
]

{ #category : #'api - initialization' }
GtNotificationDecoratingEventElement >> element: anElement [
	self
		assert: [ self childrenCount isZero ] 
		description: [ 'You can add only one child' ].
	self addChild: anElement.
]

{ #category : #'private - accessing' }
GtNotificationDecoratingEventElement >> elementDo: aBlock [
	| anElement |
	anElement := self children
		at: 1
		ifAbsent: [ ^ self ]. 
	aBlock value: anElement.
]

{ #category : #'api - accessing' }
GtNotificationDecoratingEventElement >> event [
	<return: #GtNotificationEvent>
	^ self element event
]

{ #category : #'api - accessing' }
GtNotificationDecoratingEventElement >> event: aGtNotificationEvent [
	self element event: aGtNotificationEvent
]

{ #category : #initialization }
GtNotificationDecoratingEventElement >> initialize [
	super initialize.
	self initializeElement.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInheritIn: [ :aBlock | self elementDo: aBlock ];
		vAnyToFitContentIn: [ :aBlock | self elementDo: aBlock ]).
]

{ #category : #initialization }
GtNotificationDecoratingEventElement >> initializeElement [
	self
		"addLook: BrShadowLook new;"
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		background: Color white;
		padding: (BlInsets top: 5 right: 10 bottom: 10 left: 10);
		margin: (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	
]

Class {
	#name : #GtNotificationBorderElement,
	#superclass : #GtNotificationElement,
	#instVars : [
		'borderElement'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - accessing' }
GtNotificationBorderElement >> borderDo: aBlock [
	"Users can configure the border element"
	self borderElement ifNotNil: aBlock
]

{ #category : #'private - accessing' }
GtNotificationBorderElement >> borderElement [
	<return: #BrFrame>
	^ borderElement
]

{ #category : #'api - accessing' }
GtNotificationBorderElement >> containerDo: aBlock [
	"Users can fill the container with other elements"
	self borderElement ifNotNil: aBlock
]

{ #category : #initialization }
GtNotificationBorderElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtNotificationBorderElement >> initialize [
	super initialize.
	self initializeBorderElement.
	self initializeElement.

	self addChild: self borderElement as: #border.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self borderElement;
		vAnyToFitContent: self borderElement).
]

{ #category : #initialization }
GtNotificationBorderElement >> initializeBorderElement [
	borderElement := BrVerticalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		margin: (BlInsets all: 7);
		padding: (BlInsets top: 5 right: 10 bottom: 10 left: 10)
]

{ #category : #initialization }
GtNotificationBorderElement >> initializeElement [
	self 
		background: Color white;
		padding: (BlInsets top: 5 right: 5 bottom: 0 left: 5)

]

{ #category : #'api - initialization' }
GtNotificationBorderElement >> withCloseButtonAction: aBlock [
	GtNotificationCloseButtonBuilder new 
		element: self;
		action: aBlock;
		build
]

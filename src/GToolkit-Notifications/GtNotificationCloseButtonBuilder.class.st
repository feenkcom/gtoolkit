Class {
	#name : #GtNotificationCloseButtonBuilder,
	#superclass : #GtNotificationElementBuilder,
	#instVars : [
		'action'
	],
	#category : #'GToolkit-Notifications-UI Support'
}

{ #category : #'api - accessing' }
GtNotificationCloseButtonBuilder >> action [
	^ action
]

{ #category : #'api - accessing' }
GtNotificationCloseButtonBuilder >> action: anObject [
	action := anObject
]

{ #category : #'private - asserting' }
GtNotificationCloseButtonBuilder >> assertCloseButton [
	self
		assert: [ self element 
			directChildNamed: self closeButtonName
			ifFound: [ false ] 
			ifNone: [ true ] ] 
		description: [ 'Close button can be installed only once' ]
]

{ #category : #'api - building' }
GtNotificationCloseButtonBuilder >> build [
	| aButton |
	self assertCloseButton.
	aButton := self newCloseButton.
	self action ifNotNil: [ 
		aButton action: self action ].
	self element addChild: aButton as: self closeButtonName.
]

{ #category : #'private - accessing' }
GtNotificationCloseButtonBuilder >> closeButtonName [
	^ #closeButton
]

{ #category : #'private - instance creation' }
GtNotificationCloseButtonBuilder >> newCloseButton [
	^ GtInspectorRoundButtonStencil small asElement
		icon: GtInspectorPlusIconStencil close asElement;
		elevation: (BlRelativeElevation elevation: 20);
		constraintsDo: [ :c | 
			c frame horizontal alignRight.
			c frame vertical alignTop ]
]

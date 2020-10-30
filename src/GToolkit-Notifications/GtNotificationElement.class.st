Class {
	#name : #GtNotificationElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #defaults }
GtNotificationElement >> defaultHorizontalResizerModel [
	^ BrLayoutHorizontalResizerModel matchParent
]

{ #category : #defaults }
GtNotificationElement >> defaultVercialResizerModel [
	^ BrLayoutVerticalResizerModel matchParent
]

{ #category : #initialization }
GtNotificationElement >> initialize [
	super initialize.
	self addInteractiveModelState: self defaultHorizontalResizerModel.
	self addInteractiveModelState: self defaultVercialResizerModel
]

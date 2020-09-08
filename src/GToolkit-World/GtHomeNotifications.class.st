Class {
	#name : #GtHomeNotifications,
	#superclass : #BlElement,
	#category : #'GToolkit-World-UI'
}

{ #category : #updating }
GtHomeNotifications >> availableNotifications [
	^ { 
		self takeATourNotification 
	}
]

{ #category : #updating }
GtHomeNotifications >> clearContent [
	self removeChildren.
	self visibility: BlVisibility gone
]

{ #category : #testing }
GtHomeNotifications >> hasNotifications [
	^ self hasChildren 
]

{ #category : #initialization }
GtHomeNotifications >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
]

{ #category : #'instance creation' }
GtHomeNotifications >> showSpaceWithTitle: aString with: anElement from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 1200@600.
	aSpace addChild: anElement asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace
]

{ #category : #accessing }
GtHomeNotifications >> statusRegistry [
	^ GtNotificationStatusRegistry loadDefault
]

{ #category : #'instance creation' }
GtHomeNotifications >> takeATourNotification [
	^ GtNotification new
		id: 'notification/take-a-tour';
		openAction: [ :cardElement |
			self
				showSpaceWithTitle: 'Tour'
				with: GtTour new create makeArrowsVisible
				from: cardElement ];
		refreshAction: [ self updateWidget ];
		cardStencil: self takeATourStencil
]

{ #category : #'instance creation' }
GtHomeNotifications >> takeATourStencil [
	^ GtNotificationCardStencil new
		headerText: 'New to Glamorous Toolkit?';
		actionText: 'Take a tour';
		tooltipText: 'Take an interactive tour through tools and engines'
]

{ #category : #updating }
GtHomeNotifications >> updateWidget [
	| availableNotifications validNotifications statusRegistry |
	availableNotifications := self availableNotifications.
	
	statusRegistry := self statusRegistry.
	availableNotifications do: [ :aNews |
		aNews status: (statusRegistry statusForId: aNews id) ].
	
	validNotifications := availableNotifications reject: [ :aNews | 
		aNews status isViewed or: [
			aNews status isDismissed ] ].
	
	self removeChildren.
	validNotifications 
		ifEmpty: [
			self visibility: BlVisibility gone ]
		ifNotEmpty: [ validNotifications do: [ :aNews |
			self visibility: BlVisibility visible.
			self addChild: aNews cardStencil create ] ]
]

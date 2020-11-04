Class {
	#name : #GtNotificationJobElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'progressElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - asserting' }
GtNotificationJobElement >> assertJob: aJob [ 
	self 
		assert: [ aJob isNotNil ] 
		description: [ 'Job must be non-nil' ].
]

{ #category : #defaults }
GtNotificationJobElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterLeft
]

{ #category : #'api - actions' }
GtNotificationJobElement >> dismiss [
	self fireEvent: (GtNotificationJobDismissWish new notification: self event)
]

{ #category : #initialization }
GtNotificationJobElement >> initialize [
	super initialize.
	self initializeProgressElement.
	
	self addChild: self progressElement as: #progress.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self progressElement;
		vAnyToFitContent: self progressElement).
]

{ #category : #initialization }
GtNotificationJobElement >> initializeProgressElement [
	progressElement := BrProgress new
		fixedLabel: '';
		look: BrGlamorousProgressWithLabelAndBarLook;
		layoutDo: [ :aLayout | 
			aLayout alignCenterLeft ]
]

{ #category : #'private - accessing' }
GtNotificationJobElement >> jobDo: aBlock [
	self eventDo: [ :anEvent | anEvent job ifNotNil: aBlock ]
]

{ #category : #'hooks - children' }
GtNotificationJobElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self subscribeToJob.
	self updateElement.
]

{ #category : #'private - hooks' }
GtNotificationJobElement >> onEventChanged [
	super onEventChanged.
	self updateElement.
]

{ #category : #'private - announcement handling' }
GtNotificationJobElement >> onJobChange: aJobChange [
	self jobDo: [ :aJob | 
		aJob = aJobChange job ifTrue: [
			self enqueueTask: (BlTaskAction new 
				action: [ self updateElement ] ) ] ].
]

{ #category : #'private - announcement handling' }
GtNotificationJobElement >> onJobEnd: aJobEnd [
	self jobDo: [ :aJob | 
		aJob = aJobEnd job ifTrue: [
			self unsubscribeFromJob.
			self enqueueTask: (BlTaskAction new 
				action: [ self dismiss ]) ] ].
]

{ #category : #'hooks - children' }
GtNotificationJobElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	self unsubscribeFromJob.
]

{ #category : #'private - accessing' }
GtNotificationJobElement >> progressElement [
	<return: #BrProgress>
	^ progressElement
]

{ #category : #'private - subscriptions' }
GtNotificationJobElement >> subscribeToJob [
	self jobDo: [ :aJob | 
		aJob announcer
			when: JobEnd send: #onJobEnd: to: self;
			when: JobChange send: #onJobChange: to: self ].
]

{ #category : #'private - subscriptions' }
GtNotificationJobElement >> unsubscribeFromJob [
	self jobDo: [ :aJob | 
		aJob announcer unsubscribe: self ]
]

{ #category : #'private - updating' }
GtNotificationJobElement >> updateElement [
	self jobDo: [ :aJob | 
		| aProgress |
		aProgress := aJob progress.
		aProgress := aProgress max: 0.
		aProgress := aProgress min: 1.
		self progressElement
			fixedLabel: aJob label;
			fraction: aProgress ]
]

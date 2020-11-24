Class {
	#name : #GtNotificationJobWithChildrenElement,
	#superclass : #GtNotificationJobElement,
	#instVars : [
		'containerElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - updating' }
GtNotificationJobWithChildrenElement >> addJobChild: aJob [
	| anElement |
	anElement := self newJobEventFor: aJob.
	self containerElement addChild: anElement
]

{ #category : #'private - accessing' }
GtNotificationJobWithChildrenElement >> containerElement [
	<return: #BrVerticalPane>
	^ containerElement 
]

{ #category : #'private - updating' }
GtNotificationJobWithChildrenElement >> ensureJobChild: aNewJob at: anIndex [
	| anElement |

	self jobChildrenDo: [ :eachElement | 
		eachElement jobDo: [ :aChildJob | 
			aChildJob = aNewJob ifTrue: [ ^ self ] ] ].
	anElement := self newJobEventFor: aNewJob.

	"The first child is the progress bar"
	self containerElement 
		addChild: anElement 
		at: (anIndex min: self containerElement childrenCount + 1).
]

{ #category : #initialization }
GtNotificationJobWithChildrenElement >> initialize [
	super initialize.
	self initializeContainer.
	
	self addChild: self containerElement as: #container.

	self
		when: GtNotificationJobDismissWish
		do: [ :anEvent | self onDismissWish: anEvent ].
		
	self addLook: (BrLayoutResizerLook new
		hInherit: self containerElement;
		vAnyToFitContent: self containerElement).
]

{ #category : #initialization }
GtNotificationJobWithChildrenElement >> initializeContainer [
	containerElement := BrVerticalPane new
		hMatchParent;
		vFitContent
]

{ #category : #'private - accessing' }
GtNotificationJobWithChildrenElement >> jobChildrenDo: aBlock [
	"Iterate job child elements"
	self containerElement childrenDo: aBlock
]

{ #category : #'private - instance creation' }
GtNotificationJobWithChildrenElement >> newJobEventFor: aJob [
	| anElement anEvent |
	anEvent := GtNotificationJobEvent new job: aJob.
	anElement := GtNotificationJobWithChildrenElement new
		notification: anEvent.
	anElement
		margin: anElement margin + (BlInsets left: 10) + (BlInsets top: 5).
	^ anElement
]

{ #category : #'private - event handling' }
GtNotificationJobWithChildrenElement >> onDismissWish: aWish [
	"I must be called in a UI process"
	self jobDo: [ :aJob | 
		aWish job = aJob ifTrue: [ 
			^ self ] ].
	
	self jobChildrenDo: [ :eachElement | 
		eachElement jobDo: [ :aChildJob |
			aWish job = aChildJob ifTrue: [ 
				self containerElement removeChild: eachElement.
				aWish consumed: true.
				^ self ] ] ]
]

{ #category : #'private - announcement handling' }
GtNotificationJobWithChildrenElement >> onJobStart: aJobStart [
	self jobDo: [ :aJob | 
		aJobStart job parent = aJob ifTrue: [
			self enqueueTask: (BlTaskAction new 
				action: [ self addJobChild: aJobStart job ] ) ] ].
]

{ #category : #'private - updating' }
GtNotificationJobWithChildrenElement >> removeJobElementsExcluding: aJobChildren [
	| childrensToRemove |
	childrensToRemove := Array 
		new: self containerElement childrenCount 
		streamContents: [ :aStream |
			self jobChildrenDo: [ :eachElement |
				eachElement jobDo: [ :aJob | 
					(aJobChildren includes: aJob) ifFalse: [ 
						aStream nextPut: eachElement ] ] ] ].
	self containerElement removeChildren: childrensToRemove.
]

{ #category : #'private - subscriptions' }
GtNotificationJobWithChildrenElement >> subscribeToJob [
	super subscribeToJob.
	self jobDo: [ :aJob | 
		aJob announcer
			when: JobStart send: #onJobStart: to: self ].
]

{ #category : #'private - updating' }
GtNotificationJobWithChildrenElement >> updateChildren [
	self jobDo: [ :aJob |
		| aJobChildren |
		aJobChildren := aJob children.
		self removeJobElementsExcluding: aJobChildren.
		aJobChildren withIndexDo: [ :aChildJob :anIndex | 
			self ensureJobChild: aChildJob at: anIndex ] ]
]

{ #category : #'private - updating' }
GtNotificationJobWithChildrenElement >> updateElement [
	super updateElement.
	self updateChildren.
]

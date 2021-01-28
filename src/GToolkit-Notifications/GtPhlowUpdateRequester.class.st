"
I handle asynchronous ${class:BlElement}$ update requests.
When ${method:GtPhlowUpdateRequester>>#requestUpdate|label=#selector}$ is called, I ${method:GtPhlowUpdateRequester>>#postponeUpdate|label=schedule}$ an update and execute an ${method:GtPhlowUpdateRequester>>#action|label=#selector}$, when the ${class:BlElement}$ is  ${method:BlElement>>#isAttachedToSceneGraph|label=attached to a scene graph}$.
! Public API
- ${method:GtPhlowUpdateRequester>>#element:|label=#selector}$ a ${class:BlElement}$ on which updates are performed,
- ${method:GtPhlowUpdateRequester>>#action:|label=#selector}$ a valuable which is evaluated when it is time to update the ${class:BlElement}$,
- ${method:GtPhlowUpdateRequester>>#element:selector:|label=#selector}$ an utility method that combines the above two methods,
- ${method:GtPhlowUpdateRequester>>#requestUpdate|label=#selector}$ schedules the ${class:BlElement}$ update.
! Example
!!! Requester Initialization
The following example indicates how I can be initialized, having a ${class:BlElement}$ with a given background: ${example:GtPhlowUpdateRequesterExamples>>#requesterWithElementAndAction|codeExpanded=false|previewExpanded=true}$
!! Requesting Update
The background is updated on the ${method:GtPhlowUpdateRequester>>#requestUpdate|label=request}$ when the ${class:BlElement}$ is attached to a scene graph: ${example:GtPhlowUpdateRequesterExamples>>#updateRequest_AfterElementAddedInSceneGraph|codeExpanded=false|previewExpanded=true}$  
"
Class {
	#name : #GtPhlowUpdateRequester,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'mutex',
		'isUpdateRequested',
		'action',
		'postponedDuration'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'private - accessing' }
GtPhlowUpdateRequester >> action [
	"Return a valuable object that understands #cull:, receiving [ :anElement | ... ]"
	^ action 
]

{ #category : #'api - initialization' }
GtPhlowUpdateRequester >> action: anAction [
	"Set an update action, an object that understands #cull:, receiving [ :anElement | ... ]"
	self assertAction: anAction.
	action := anAction.
]

{ #category : #'private - asserting' }
GtPhlowUpdateRequester >> assertAction: anAction [ 
	self 
		assert: [ anAction isNotNil ] 
		description: [ 'Update action must be non-nil' ].
]

{ #category : #'private - asserting' }
GtPhlowUpdateRequester >> assertElement: anElement [ 
	self 
		assert: [ anElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	self 
		assert: [ element isNil ] 
		description: [ 'Element can be initialized only once' ].
]

{ #category : #'private - asserting' }
GtPhlowUpdateRequester >> assertPostponedDuration: aDuration [
	self 
		assert: [ aDuration isNotNil ] 
		description: [ 'Posponed duration must be non-nil' ].
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> beUpdateRequestedIfDoneEarlierDo: aBlock [
	mutex critical: [ 
		self isUpdateRequested ifTrue: aBlock.
		isUpdateRequested := true. ]
]

{ #category : #defaults }
GtPhlowUpdateRequester >> defaultAction [
	^ [ :anElement | "do nothing" ]
]

{ #category : #defaults }
GtPhlowUpdateRequester >> defaultPostponedDuration [
	^ 100 milliSeconds
]

{ #category : #'private - accessing' }
GtPhlowUpdateRequester >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'api - initialization' }
GtPhlowUpdateRequester >> element: anElement [
	self assertElement: anElement.
	element := anElement.
	self subscribeToElement.
]

{ #category : #'api - initialization' }
GtPhlowUpdateRequester >> element: anElement selector: aSelector [
	self element: anElement.
	self action: (MessageSend receiver: anElement selector: aSelector).
]

{ #category : #'private - accessing' }
GtPhlowUpdateRequester >> elementDo: aBlock [
	self element ifNotNil: aBlock
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> enqueueUpdate [
	self elementDo: [ :anElement | 
		anElement enqueueTask: (BlTaskAction new action: [
			self updateNow ]) ].
]

{ #category : #'gt-extensions' }
GtPhlowUpdateRequester >> gtPreviewFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : #initialization }
GtPhlowUpdateRequester >> initialize [
	super initialize.
	mutex := Mutex new.
	isUpdateRequested := false.
	action := self defaultAction.
	postponedDuration := self defaultPostponedDuration.
]

{ #category : #'private - testing' }
GtPhlowUpdateRequester >> isUpdateRequested [
	<return: #Boolean>
	^ isUpdateRequested
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> mayUpdateNow [
	mutex critical: [ 
		self isUpdateRequested ifFalse: [ ^ self ] ]. 
	self updateNow
]

{ #category : #'private - event handling' }
GtPhlowUpdateRequester >> onElementAddedTooSceneGraph [
	self mayUpdateNow
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> postponeUpdate [
	self elementDo: [ :anElement | 
		self beUpdateRequestedIfDoneEarlierDo: [ ^ self ].
		BlUseAsyncFeatures 
			ifEnabledDo: [ 
				anElement isAttachedToSceneGraph
					ifFalse: [ ^ self ].
				
				"Update requester should perform an update as soon as possible, especially if
				postponed delay (duration) is zero. It means that there should be no unnecessary skipped frames.
				What does it mean? Let's take a look at the frame phase order, roughly:
					- handle events
					- run tasks
					- redraw
				From usability and smoothness perspective all zero delay updates that are scheduled during event processing phase
				must be handled during tasks phase so that UI related changes appear on the screen within the same frame, without delays.
				If even one frame is skipped users would notice UI jumping/jiggling/flickering.

				We explicitly handle zero delay case by instantly enqueuing an update task to the element so that it can be processed
				as soon as possible. If there is a non-zero delay we schedule an update with the help of a TaskAt queue which may skip
				an undefined amount of frames."
				self postponedDuration isZero
					ifTrue: [ self enqueueUpdate ]
					ifFalse: [
						BlTaskAtQueue default
							schedule: [ self enqueueUpdate ]
							at: self postponedTime ] ]
			otherwise: [ self updateNow ] ]
]

{ #category : #'private - accessing' }
GtPhlowUpdateRequester >> postponedDuration [
	<return: #Duration>
	^ postponedDuration ifNil: [ self defaultPostponedDuration ]
]

{ #category : #'api - initialization' }
GtPhlowUpdateRequester >> postponedDuration: aDuration [
	self assertPostponedDuration: aDuration.
	postponedDuration := aDuration.
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> postponedTime [
	| aNow |
	self elementDo: [ :anElement | 
		aNow := anElement space 
			ifNotNil: [ :aSpace | aSpace time now ] 
			ifNil: [ BlTime real now ] ].
	aNow ifNil: [ aNow := BlTime real now ].
	^ aNow + self postponedDuration.
]

{ #category : #'api - updating' }
GtPhlowUpdateRequester >> requestUpdate [
	self postponeUpdate.
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> resetUpdateRequested [
	mutex critical: [ 
		isUpdateRequested := false ].
]

{ #category : #'private - subscriptions' }
GtPhlowUpdateRequester >> subscribeToElement [
	self element
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onElementAddedTooSceneGraph ]
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> updateElement [
	"I should be called from a UI process."
	self elementDo: [ :anElement | 
		self action cull: anElement ]
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> updateNow [
	self resetUpdateRequested.
	self updateElement.
]

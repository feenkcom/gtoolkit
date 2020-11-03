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
		'action'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #accessing }
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

{ #category : #accessing }
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
				anElement isAttachedToSceneGraph ifFalse: [ ^ self ].
				BlTaskAtQueue default
					schedule: [ self enqueueUpdate ]
					at: self postponedTime ]
			otherwise: [ 
				self updateNow ] ]
]

{ #category : #'private - updating' }
GtPhlowUpdateRequester >> postponedTime [
	| aNow |
	self elementDo: [ :anElement | 
		aNow := anElement space 
			ifNotNil: [ :aSpace | aSpace time now ] 
			ifNil: [ BlTime real now ] ].
	aNow ifNil: [ aNow := BlTime real now ].
	^ aNow + 300 milliSeconds.
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

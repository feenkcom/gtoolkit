Class {
	#name : #GtPhlowUpdateRequesterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - requester' }
GtPhlowUpdateRequesterExamples >> basicRequester [
	<gtExample>
	| aRequester |
	aRequester := GtPhlowUpdateRequester new.
	self assert: aRequester element isNil.
	self assert: aRequester action isNotNil.
	self assert: aRequester isUpdateRequested not.
	^ aRequester
]

{ #category : #'examples - support' }
GtPhlowUpdateRequesterExamples >> defaultBackgroundColor [
	^ Color yellow alpha: 0.2
]

{ #category : #'examples - support' }
GtPhlowUpdateRequesterExamples >> element [
	<gtExample>
	^ BlElement new
		background: self defaultBackgroundColor;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c margin: (BlInsets all: 10) ].
]

{ #category : #accessing }
GtPhlowUpdateRequesterExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Update Requester Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #'examples - requester' }
GtPhlowUpdateRequesterExamples >> requesterWithElementAndAction [
	<gtExample>
	| aRequester anElement anAction |
	aRequester := self basicRequester.
	
	anElement := self element.
	anAction := [ :theElement | 
		theElement background: self updatedBackgroundColor ].
	
	aRequester element: anElement.
	aRequester action: anAction.
	
	self assert: aRequester element equals: anElement.
	self assert: aRequester action equals: anAction.
	self assert: aRequester isUpdateRequested not.
	self assert: anElement taskQueue tasks size equals: 0.
	
	^ aRequester
]

{ #category : #accessing }
GtPhlowUpdateRequesterExamples >> updateRequest_AfterElementAddedInSceneGraph [
	<gtExample>
	| aRequester anElement anAction aSemaphore aTimeout aSpace |
	aSemaphore := Semaphore new.
	aRequester := self basicRequester.
	anElement := self element.
	anAction := [ :theElement | 
		theElement background: self updatedBackgroundColor.
		aSemaphore signal ].
	aRequester element: anElement.
	aRequester action: anAction.

	aSpace := self newSpace.
	aSpace addChild: anElement.
	aSpace pulse.
		
	aRequester requestUpdate.
	
	BlTaskAtQueue default
		schedule: [ 
			300 milliSeconds wait. 
			aSemaphore signal ]
		at: aRequester postponedTime.
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	
	aSpace pulse.
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	
	self 
		assert: aTimeout not 
		description: 'Semaphore was not signaled on time'.
	self assert: aRequester isUpdateRequested not.
	self assert: aRequester element taskQueue tasks size equals: 0.
	
	anElement removeFromParent.
	^ aRequester
]

{ #category : #accessing }
GtPhlowUpdateRequesterExamples >> updateRequest_BeforeElementAddedInSceneGraph [
	<gtExample>
	| aRequester anElement anAction aSemaphore aTimeout aSpace |
	aSemaphore := Semaphore new.
	aRequester := self basicRequester.
	anElement := self element.
	anAction := [ :theElement | 
		theElement background: self updatedBackgroundColor.
		aSemaphore signal ].
	aRequester element: anElement.
	aRequester action: anAction.

	aRequester requestUpdate.

	aSpace := self newSpace.
	aSpace addChild: anElement.
	aSpace pulse.
		
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	
	self 
		assert: aTimeout not 
		description: 'Semaphore was not signaled on time'.
	self assert: aRequester isUpdateRequested not.
	self assert: aRequester element taskQueue tasks size equals: 0.
	
	anElement removeFromParent.
	^ aRequester
]

{ #category : #'examples - requester' }
GtPhlowUpdateRequesterExamples >> updateRequest_ElementNotInSceneGraph [
	<gtExample>
	| aRequester aSemaphore aTimeout |
	aSemaphore := Semaphore new.
	aRequester := self requesterWithElementAndAction.
	aRequester requestUpdate.
	BlTaskAtQueue default
		schedule: [ 
			100 milliSeconds wait. 
			aSemaphore signal ]
		at: aRequester postponedTime.
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self 
		assert: aTimeout not 
		description: 'Semaphore was not signaled on time'.
	self assert: aRequester isUpdateRequested.
	self assert: aRequester element taskQueue tasks size equals: 0.
	^ aRequester
]

{ #category : #'examples - support' }
GtPhlowUpdateRequesterExamples >> updatedBackgroundColor [
	^ Color blue alpha: 0.2
]

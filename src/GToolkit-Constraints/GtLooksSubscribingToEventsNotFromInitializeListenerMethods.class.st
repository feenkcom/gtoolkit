Class {
	#name : #GtLooksSubscribingToEventsNotFromInitializeListenerMethods,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #utilities }
GtLooksSubscribingToEventsNotFromInitializeListenerMethods class >> lookMethodWithEvents [
	<gtExample>
	^ Array streamContents: [ :aStream |
		BrLook withAllSubclassesDo: [ :eachLookClass |			
			eachLookClass methodsDo: [ :eachMethod |
				| referencedEvents |
				referencedEvents := eachMethod referencedClasses select: [ :each | each inheritsFrom: BlEvent ].
				referencedEvents ifNotEmpty: [ aStream nextPut: eachMethod ] ] ] ]
]

{ #category : #utilities }
GtLooksSubscribingToEventsNotFromInitializeListenerMethods class >> lookMethodWithEventsOutsideOfInitializeListeners [
	<gtExample>
	| validSelectors |

	validSelectors := { 
		#initializeListeners.
		#initializeRequests
	 } asSet.

	^ Array streamContents: [ :aStream |
		BrLook withAllSubclassesDo: [ :eachLookClass |
			
			eachLookClass methodsDo: [ :eachMethod |
				| referencedEvents |
				referencedEvents := eachMethod referencedClasses select: [ :each | each inheritsFrom: BlEvent ].
				
				referencedEvents ifNotEmpty: [
					(validSelectors includes: eachMethod selector)
						ifFalse: [ aStream nextPut: eachMethod ] ]	 ] ] ]
]

{ #category : #accessing }
GtLooksSubscribingToEventsNotFromInitializeListenerMethods >> description [
	^ 'Looks should subscribe to events only from initializeListeners'
]

{ #category : #accessing }
GtLooksSubscribingToEventsNotFromInitializeListenerMethods >> issues [
	| listenerSelectors |
	
	true ifTrue: [ ^ #() ].
	
	listenerSelectors := { 
		#when:do:.
		#when:reply:.
		#addEventHandler:.
		#addEventHandlerOn:do:
	 } asSet.

	^ Array streamContents: [ :aStream |
		BrLook withAllSubclassesDo: [ :eachLookClass |
			
			eachLookClass methodsDo: [ :eachMethod |
				| referencedEvents |
				referencedEvents := eachMethod referencedClasses select: [ :each | each inheritsFrom: BlEvent ].
				
				referencedEvents ifNotEmpty: [
					eachMethod ast variableNodes
						select: [ :eachNode | eachNode isGlobal and: [ eachNode binding value inheritsFrom: BlEvent ] ]
						thenDo: [ :eachNode |
							(eachNode parent isMessage and: [ listenerSelectors includes: eachNode parent selector ])
								ifTrue: [ eachMethod selector = #initializeListeners
									ifFalse: [ aStream nextPut: eachMethod ] ].
						] ]	 ] ] ]
]

{ #category : #accessing }
GtLooksSubscribingToEventsNotFromInitializeListenerMethods >> name [
	^ 'We should only subscribe to events in initializeListeners method'
]

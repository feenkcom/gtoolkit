Class {
	#name : #GSubclassesOfExternalObjectShouldImplementStartUp,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #utilities }
GSubclassesOfExternalObjectShouldImplementStartUp class >> lookMethodWithEvents [
	<gtExample>
	^ Array streamContents: [ :aStream |
		BrAptitude withAllSubclassesDo: [ :eachLookClass |			
			eachLookClass methodsDo: [ :eachMethod |
				| referencedEvents |
				referencedEvents := eachMethod referencedClasses select: [ :each | each inheritsFrom: BlEvent ].
				referencedEvents ifNotEmpty: [ aStream nextPut: eachMethod ] ] ] ]
]

{ #category : #utilities }
GSubclassesOfExternalObjectShouldImplementStartUp class >> lookMethodWithEventsOutsideOfInitializeListeners [
	<gtExample>
	| validSelectors |

	validSelectors := { 
		#initializeListeners.
		#initializeRequests
	 } asSet.

	^ Array streamContents: [ :aStream |
		BrAptitude withAllSubclassesDo: [ :eachLookClass |
			
			eachLookClass methodsDo: [ :eachMethod |
				| referencedEvents |
				referencedEvents := eachMethod referencedClasses select: [ :each | each inheritsFrom: BlEvent ].
				
				referencedEvents ifNotEmpty: [
					(validSelectors includes: eachMethod selector)
						ifFalse: [ aStream nextPut: eachMethod ] ]	 ] ] ]
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> description [
	^ 'If #startUp: is not implemented and a class is registered in a SessionManager, then ExteralObject>>#startUp: will be called multiple times nulling all external addresses.'
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> issues [	
	^ (ExternalObject allSubclasses
		select: [ :each | SessionManager default hasRegistered: each name ])
			select: [ :each | (each class includesSelector: #startUp:) not ]
]

{ #category : #accessing }
GSubclassesOfExternalObjectShouldImplementStartUp >> name [
	^ 'Subclasses of ExternalObject must implement #startUp:'
]

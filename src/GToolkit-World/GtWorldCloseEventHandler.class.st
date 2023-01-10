Class {
	#name : #GtWorldCloseEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'GToolkit-World-UI'
}

{ #category : #'api - accessing' }
GtWorldCloseEventHandler >> eventsToHandle [
	^ { BlSpaceCloseRequest }
]

{ #category : #'window handlers' }
GtWorldCloseEventHandler >> spaceCloseRequest: anEvent [
	"fallback to the default action (close) if this is not the last world"
	| otherSpaces |
	
	otherSpaces := ((BlSpace allSubInstances
		select: [ :eachSpace | eachSpace isOpened ])
		select: [ :eachSpace | eachSpace ~~ anEvent currentTarget ])
		select: [ :eachSpace | eachSpace eventDispatcher
			hasEventHandlerSuchThat: [ :eachEventHandler | eachEventHandler class == self class ] ] .

	"there are other spaces with this event handler, close normally"
	otherSpaces isNotEmpty
		ifTrue: [ ^ self ].

	anEvent shouldClose: false.
	anEvent currentTarget showShutdownPrompt
]

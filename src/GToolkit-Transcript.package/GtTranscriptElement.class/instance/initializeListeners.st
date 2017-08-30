initialization
initializeListeners
	scrollButtonElement addEventHandlerOn: BlClickEvent do: [ :anEvent |
		self isAutoScrollEnabled
			ifTrue: [ self disableAutoScroll ]
			ifFalse: [ self enableAutoScroll ].
		anEvent consumed: true ].
	
	editorElement
		addEventHandlerOn: BlInfiniteScrolledEvent
		do: [ :anEvent |
			anEvent delta y isZero not
				ifTrue: [ self isAutoScrollEnabled ifTrue: [ self disableAutoScroll ] ] ]
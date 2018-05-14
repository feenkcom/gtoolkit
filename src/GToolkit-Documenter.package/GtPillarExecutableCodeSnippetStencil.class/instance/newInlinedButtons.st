instance creation
newInlinedButtons
	"Return a preview element that is displayed in a document"

	<return: #BlElement>
	| aComposite |
	aComposite := self newInlinedCompositeElement.
	aComposite
		addEventHandlerOn: BlElementRemovedEvent
		do: [ self codeSnippet announcer unsubscribe: self ].
	(self codeSnippet announcer
		subscribe: GtCodeSnippetExecutionAnnouncement
		send: #handleCodeSnippetExecutionAnnouncement:
		to: self) subscriber: aComposite.
	aComposite addChild: self newPlayButton.
	^ aComposite
instance creation
newInlinedButtons
	"Return a preview element that is displayed in a document"

	<return: #BlElement>
	| aComposite |
	aComposite := BlElement new look: GtPillarInlinedCompositeLook.
	aComposite addEventHandlerOn: BlElementRemovedEvent do: [ self codeSnippet announcer unsubscribe: self ].
	(self codeSnippet announcer 
		subscribe: GtCodeSnippetExecutionAnnouncement 
		send: #handleCodeSnippetExecutionAnnouncement:
		to: self) subscriber: aComposite.
	self codeSnippet hasResult ifTrue: [ aComposite addChild: self newOutsInformationElement ].
	aComposite addChild: self newPlayButton.
	^ aComposite
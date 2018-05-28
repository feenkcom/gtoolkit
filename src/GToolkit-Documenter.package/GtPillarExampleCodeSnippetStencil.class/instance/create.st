instance creation
create
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	| aChildrenElementBlock aComposite |
	
	aChildrenElementBlock := [ 
		self codeSnippet isMethodDefined 
			ifFalse: [ self newErrorMessageElement ]
			ifTrue: [ self codeSnippet shouldDisplayResult
				ifTrue: [ self newPreviewElementFromShowParameter ]
				ifFalse: [ self newPreviewEditorElement ] ] ].
		
	aComposite := self newTransparentCompositeElement.
	aComposite addChild: aChildrenElementBlock value.

	self codeSnippet 
		subscribe: GtExampleClassUpdatedAnnouncement 
		do: [ aComposite removeChildren. aComposite addChild: aChildrenElementBlock value ] 
		for: aComposite.
	
	^ aComposite
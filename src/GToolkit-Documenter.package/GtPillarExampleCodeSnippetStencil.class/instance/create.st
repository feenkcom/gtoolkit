instance creation
create
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	^ self codeSnippet shouldDisplayResult
		ifTrue: [ self newPreviewElementFromShowParameter ]
		ifFalse: [ self newPreviewEditorElement ]
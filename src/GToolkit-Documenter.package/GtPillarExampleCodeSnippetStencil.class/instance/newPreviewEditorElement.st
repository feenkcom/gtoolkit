instance creation
newPreviewEditorElement
	^ (GtExamplesStyler
		editorElementOnSourceCode: self codeSnippet methodSourceCode
		inClass: self codeSnippet methodClass) 
			margin: (BlInsets all: 10)
instance creation
newPreviewEditorElement
	^ (GtExamplesStyler
		editorElementOnSourceCode: self codeSnippet sourceCode
		inClass: self codeSnippet methodClass) 
			margin: (BlInsets all: 10)
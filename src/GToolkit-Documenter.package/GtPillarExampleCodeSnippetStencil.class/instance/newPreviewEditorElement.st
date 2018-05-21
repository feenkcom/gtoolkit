instance creation
newPreviewEditorElement
	^ (GtExamplesStyler
		editorElementOnSourceCode: self codeSnippet methodSourceCode
		inClass: self codeSnippet methodClass) 
			margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20)
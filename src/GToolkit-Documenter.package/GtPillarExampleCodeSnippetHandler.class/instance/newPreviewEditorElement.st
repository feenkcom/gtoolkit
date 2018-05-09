instance creation
newPreviewEditorElement
	^ (GtExamplesStyler
		editorElementOnSourceCode: self exampleMethod sourceCode
		inClass: self exampleMethod methodClass) margin: (BlInsets all: 10)
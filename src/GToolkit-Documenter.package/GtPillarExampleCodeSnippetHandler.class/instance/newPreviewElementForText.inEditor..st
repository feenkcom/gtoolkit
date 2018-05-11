instance creation
newPreviewElementForText: aBrText inEditor: aTextElement
	<return: #BlElement>
	^ GtPillarExampleCodeSnippetStencil new
		text: aBrText;
		editor: aTextElement;
		codeSnippet: codeSnippet;
		create
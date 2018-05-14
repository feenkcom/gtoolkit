instance creation
newPreviewElementForText: aBrText inEditor: aTextElement
	<return: #BlElement>
	^ GtPillarEpiceaBrickStencil new
		codeSnippet: self codeSnippet;
		create
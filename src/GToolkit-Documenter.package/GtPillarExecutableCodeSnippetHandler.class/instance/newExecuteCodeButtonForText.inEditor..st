instance creation
newExecuteCodeButtonForText: aBrText inEditor: aTextElement
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>

	^ GtPillarExecuteCodeButtonStencil new
		text: aBrText;
		editor: aTextElement;
		codeSnippet: codeSnippet;
		icon: GtDocumenterConstants defaultExecuteButtonIcon;
		create
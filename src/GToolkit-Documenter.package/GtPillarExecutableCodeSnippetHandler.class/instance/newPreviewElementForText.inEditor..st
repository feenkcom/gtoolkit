instance creation
newPreviewElementForText: aBrText inEditor: aTextElement
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>
	^ GtPillarScriptExecutorStencil new
		text: aBrText;
		editor: aTextElement;
		workspace: workspace;
		description: 'You will execute a script...';
		label: self buttonLabelString;
		icon: GtDocumenterConstants defaultExecuteButtonIcon;
		codeSnippet: tokens scriptBodyString;
		newPreviewElement
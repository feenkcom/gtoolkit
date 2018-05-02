instance creation
newPreviewElement
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>
	^ GtPillarScriptExecutorStencil new
		description: 'You will execute a script...';
		label: self buttonLabelString;
		icon: GtDocumenterConstants defaultExecuteButtonIcon;
		codeSnippet: self scriptBodyString;
		workspace: workspace;
		newPreviewElement
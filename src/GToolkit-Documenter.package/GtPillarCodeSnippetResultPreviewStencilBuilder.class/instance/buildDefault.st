api - instantiation
buildDefault
	^ GtPillarCodeSnippetResultPreviewStencil new
		text: self text;
		editor: self editor;
		codeSnippet: self codeSnippet
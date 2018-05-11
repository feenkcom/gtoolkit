private
mayExpandResultPreviewIn: exampleElement
	self codeSnippet shouldExpandPreview ifTrue: [ exampleElement showPreview ]
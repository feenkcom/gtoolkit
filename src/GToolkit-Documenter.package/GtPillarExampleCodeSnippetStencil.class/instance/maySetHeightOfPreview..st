private
maySetHeightOfPreview: exampleElement
	self codeSnippet isPreviewHeightDefined
		ifTrue: [ exampleElement previewHeight: self codeSnippet previewHeight ]
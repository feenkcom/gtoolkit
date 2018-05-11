instance creation
newPreviewElementFromShowParameter
	| exampleElement |
	exampleElement := GtPillarExampleElement
		withCode: self codeSnippet shouldDisplayCode.
	self maySetHeightOfPreview: exampleElement.
	exampleElement
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	exampleElement
		example: self codeSnippet exampleMethod gtExample
		showBlock: [ :returnValue | 
			| composite |
			composite := BlElement new
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ].
			returnValue
				perform: self codeSnippet showMessageName
				withArguments: {composite}.
			composite ].
	self mayExpandResultPreviewIn: exampleElement.
	^ exampleElement
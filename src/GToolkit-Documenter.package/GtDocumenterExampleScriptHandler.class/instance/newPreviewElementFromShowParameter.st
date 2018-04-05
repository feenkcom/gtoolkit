instance creation
newPreviewElementFromShowParameter
	| exampleElement |
	exampleElement := GtPillarExampleElement
		withCode: self shouldDisplayCode.
	self maySetHeightOfPreview: exampleElement.
	exampleElement
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	exampleElement
		example: self exampleMethod gtExample
		showBlock: [ :returnValue | 
			| composite |
			composite := BlElement new
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ].
			returnValue
				perform: self showParameterValue
				withArguments: {composite}.
			composite ].
	self mayExpandResultPreviewIn: exampleElement.
	^ exampleElement
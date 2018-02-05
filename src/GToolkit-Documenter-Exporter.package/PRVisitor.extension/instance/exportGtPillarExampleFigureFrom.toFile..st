*GToolkit-Documenter-Exporter
exportGtPillarExampleFigureFrom: aGtPillarExampleScript toFile: aFileReference 
	| exampleElement form |
	exampleElement := GtPillarExampleElement withCode: false.
	exampleElement previewHeight: aGtPillarExampleScript height.
	exampleElement
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	exampleElement
		example: aGtPillarExampleScript exampleCompiledMethod gtExample
		showBlock: [ :returnValue | 
			| composite |
			composite := BlElement new
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ].
			returnValue
				perform: aGtPillarExampleScript show
				withArguments: { composite }.
			composite ].
	form := exampleElement asSpartaForm.
	PNGReadWriter putForm: form onFileNamed: aFileReference fullName.
*GToolkit-Documenter-Exporter
exportGtPillarExampleFigureFrom: aGtPillarExampleScript toFile: aFileReference 
	| exampleElement form |
	exampleElement := GtPillarExampleElement withCode: false.
	exampleElement previewHeight: aGtPillarExampleScript height.
	exampleElement
		background: Color white;
		margin: (BlInsets all: 10);
		size: 500 @ 500.
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
	aFileReference ensureDelete.
	PNGReadWriter putForm: form onFileNamed: aFileReference fullName.
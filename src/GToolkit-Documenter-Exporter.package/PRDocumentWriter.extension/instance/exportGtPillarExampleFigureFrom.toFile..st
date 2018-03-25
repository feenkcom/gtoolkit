*GToolkit-Documenter-Exporter
exportGtPillarExampleFigureFrom: aGtPillarExampleScript toFile: aFileReference 
	| anExampleReturnValue aContainer |
	
	anExampleReturnValue := aGtPillarExampleScript exampleCompiledMethod gtExample returnValue.
	
	aContainer := GtPillarExporterContainerElement new.
	"recommended size"
	aContainer size: 500@300.

	anExampleReturnValue
		perform: aGtPillarExampleScript show
		withArguments: { aContainer }.
	
	aContainer forceLayout.

	aFileReference ensureDelete.
	BlSvgExporter new element: aContainer; fileName: aFileReference; export.

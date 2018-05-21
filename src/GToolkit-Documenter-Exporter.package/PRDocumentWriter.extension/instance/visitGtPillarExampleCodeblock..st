*GToolkit-Documenter-Exporter
visitGtPillarExampleCodeblock: aGtPillarExampleScript
	| fileName directory fileReference |
	fileName := super visitGtPillarExampleCodeblock: aGtPillarExampleScript.
	fileName ifNil: [ ^ nil ].
	directory := self configuration outputDirectory asFileReference / 'gt-figures'.
	directory ensureCreateDirectory.
	fileReference := directory / fileName.
	self
		exportGtPillarExampleFigureFrom: aGtPillarExampleScript
		toFile: fileReference
*GToolkit-Documenter-Exporter
visitGtPillarExampleScript: aGtPillarExampleScript
	| fileName directory fileReference |
	fileName := super visitGtPillarExampleScript: aGtPillarExampleScript.
	directory := self configuration outputDirectory asFileReference / 'gt-figures'.
	directory ensureCreateDirectory.
	fileReference := directory / fileName.
	self
		exportGtPillarExampleFigureFrom: aGtPillarExampleScript
		toFile: fileReference
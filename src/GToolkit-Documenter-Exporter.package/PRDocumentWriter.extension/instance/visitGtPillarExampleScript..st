*GToolkit-Documenter-Exporter
visitGtPillarExampleScript: aGtPillarExampleScript
	| fileName directory fileReference |
	fileName := super visitGtPillarExampleScript: aGtPillarExampleScript.
	fileName ifNil: [ ^ nil ].
	directory := self configuration outputDirectory asFileReference / 'gt-figures'.
	directory ensureCreateDirectory.
	fileReference := directory / fileName.
	self
		exportGtPillarExampleFigureFrom: aGtPillarExampleScript
		toFile: fileReference
*GToolkit-Documenter-Exporter
visitGtPillarExampleScript: aGtPillarExampleScript 
	aGtPillarExampleScript hasText ifTrue: [ ^ self visitCodeblock: aGtPillarExampleScript ].
	canvas raw: (self markupFor: aGtPillarExampleScript).
	self visitParametersOf: aGtPillarExampleScript.
	canvas raw: (self markupEndFor: aGtPillarExampleScript)
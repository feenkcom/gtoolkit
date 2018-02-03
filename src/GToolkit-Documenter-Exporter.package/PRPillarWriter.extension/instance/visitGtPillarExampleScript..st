*GToolkit-Documenter-Exporter
visitGtPillarExampleScript: aGtPillarExampleScript 
	aGtPillarExampleScript hasText ifTrue: [ ^ self visitScript: aGtPillarExampleScript ].
	canvas raw: (self markupFor: aGtPillarExampleScript).
	self visitParametersOf: aGtPillarExampleScript.
	canvas raw: (self markupEndFor: aGtPillarExampleScript)
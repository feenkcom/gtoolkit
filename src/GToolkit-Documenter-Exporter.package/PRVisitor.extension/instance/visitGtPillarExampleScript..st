*GToolkit-Documenter-Exporter
visitGtPillarExampleScript: aGtPillarExampleScript 
	| figure fileName |
	aGtPillarExampleScript noCode ifFalse: [ self visitScript: aGtPillarExampleScript ].
	aGtPillarExampleScript example ifNil: [ ^ self ].
	figure := PRFigure new.
	figure label: 'figure-', aGtPillarExampleScript example.
	figure add: (PRText content: 'Result of ', aGtPillarExampleScript example).
	fileName := String streamContents: [ :aStream | 
		aGtPillarExampleScript example asLowercase do: [ :eachChar | 
			eachChar isAlphaNumeric 
				ifTrue: [ aStream nextPut: eachChar ]
				ifFalse: [ aStream nextPut: $_ ] ] ].
	figure reference: 'file://gt-figure/', fileName.
	self visitFigure: figure.
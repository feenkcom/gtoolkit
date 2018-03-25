*GToolkit-Documenter-Exporter
visitGtPillarExampleScript: aGtPillarExampleScript
	| figure fileName |
	aGtPillarExampleScript noCode
		ifFalse: [ self visitCodePartOfGtPillarExampleScript: aGtPillarExampleScript ].
	aGtPillarExampleScript example ifNil: [ ^ self ].
	aGtPillarExampleScript show ifNil: [ ^ self ].
	figure := PRFigure new.
	figure label: 'figure-' , aGtPillarExampleScript example.
	figure
		add: (PRText content: 'Result of ' , aGtPillarExampleScript example).
	fileName := String
		streamContents: [ :aStream | 
			aGtPillarExampleScript example asLowercase
				do: [ :eachChar | 
					eachChar isAlphaNumeric
						ifTrue: [ aStream nextPut: eachChar ]
						ifFalse: [ aStream nextPut: $_ ] ].
			aStream nextPutAll: '.svg' ].
	figure reference: 'file://gt-figures/' , fileName.
	self visitFigure: figure.
	^ fileName
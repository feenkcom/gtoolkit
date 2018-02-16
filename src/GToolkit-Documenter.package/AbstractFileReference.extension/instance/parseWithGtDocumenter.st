*GToolkit-Documenter
parseWithGtDocumenter
	^ self readStreamDo: [ :aStream | 
		GtPillarExampleParser parse: aStream ].
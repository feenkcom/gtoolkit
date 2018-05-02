*GToolkit-Documenter-Exporter
parseWithGtDocumenter
	^ self readStreamDo: [ :aStream | 
		GtPillarExampleParser parse: aStream ].
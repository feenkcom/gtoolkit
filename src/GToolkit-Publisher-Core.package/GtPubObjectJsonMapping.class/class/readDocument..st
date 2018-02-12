public - convenience
readDocument: jsonDocument
	^ self read: GtPubDocument withMapping: #documentMappingFor: on: jsonDocument readStream
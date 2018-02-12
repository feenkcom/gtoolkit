*GToolkit-Publisher-Client
readJsonPost: jsonGtPubPost 
	^ self read: GtPubJsonPost withMapping: #postMappingFor: on: jsonGtPubPost readStream
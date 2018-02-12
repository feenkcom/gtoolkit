mapping - document
collectionOfAttachmentsMappingFor: aNeoJSONMapper
	aNeoJSONMapper
		for: #CollectionOfAttachments customDo: [ :mapping |
			mapping listOfElementSchema: GtPubAttachment ].
	self attachmentMappingFor: aNeoJSONMapper.
mapping - document
documentMappingFor: aNeoJSONMapper
	aNeoJSONMapper
		for: GtPubDocument do: [ :mapping |
	      mapping mapAccessor: #id.
			mapping mapAccessor: #nonce.
	      mapping mapAccessor: #title.
	      mapping mapAccessor: #description.
	      (mapping mapAccessor: #timestamp) valueSchema: DateAndTime.
			mapping mapAccessor: #root.
			(mapping mapAccessor: #attachments) valueSchema: #CollectionOfAttachments ].
	self 
		dateAndTimeMappingFor: aNeoJSONMapper;
		collectionOfAttachmentsMappingFor: aNeoJSONMapper.
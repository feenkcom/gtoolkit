mapping - document
attachmentMappingFor: aNeoJSONMapper
	aNeoJSONMapper
		for: GtPubAttachment do: [ :mapping |
	      mapping mapAccessor: #id.
	      mapping mapAccessor: #fileName to: #filename.
	      mapping mapAccessor: #fileSize to: #size.
			(mapping mapAccessor: #url) valueSchema: ZnUrl ].
	self urlMappingFor: aNeoJSONMapper.
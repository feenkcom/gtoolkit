*GToolkit-Publisher-Client
postMappingFor: aNeoJSONMapper 
	aNeoJSONMapper
		for: GtPubJsonPost do: [ :mapping |
	      mapping mapAccessor: #nonce.
	      mapping mapAccessor: #title.
	      mapping mapAccessor: #description ];
		for: GtPubDataPost do: [ :mapping |
	      mapping mapAccessor: #nonce.
	      mapping mapAccessor: #title.
	      mapping mapAccessor: #description.
			mapping mapAccessor: #root ].
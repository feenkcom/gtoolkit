mapping - basic
urlMappingFor: aNeoJSONMapper
	aNeoJSONMapper
		for: ZnUrl customDo: [ :mapping |
			mapping 
				encoder: [ :aZnUrl | aZnUrl asString ];
				decoder: [ :aStringOrNil | 
					aStringOrNil ifNotNil: [ :aString | aString asZnUrl ] ] ]
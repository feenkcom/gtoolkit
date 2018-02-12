mapping - basic
dateAndTimeMappingFor: aNeoJSONMapper
	aNeoJSONMapper
		for: DateAndTime customDo: [ :mapping |
			mapping 
				encoder: [ :aDateAndTime | aDateAndTime asString ];
				decoder: [ :aStringOrNil | 
					aStringOrNil ifNotNil: [ :aString | aString asDateAndTime ] ] ]
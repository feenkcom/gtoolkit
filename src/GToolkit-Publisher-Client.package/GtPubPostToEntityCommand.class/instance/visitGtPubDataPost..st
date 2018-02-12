visiting
visitGtPubDataPost: aGtPubDataPost 
	| part payloadJson |
	self entity: ZnMultiPartFormDataEntity new.
	payloadJson := self objectJsonMapper writePost: aGtPubDataPost.
	part := ZnMimePart fieldName: 'payload_json' value: payloadJson.
	entity addPart: part.
	aGtPubDataPost mimeParts do: [ :eachPart |
		entity addPart: eachPart ].
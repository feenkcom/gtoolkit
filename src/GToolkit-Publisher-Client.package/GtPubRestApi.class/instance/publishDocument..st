protocol - publishing
publishDocument: aGtPubPost
	| entity response |
	entity := GtPubPostToEntityCommand new
		post: aGtPubPost;
		execute;
		entity.
	response := ZnClient new
		url: self publishUrl;
		entity: entity;
		"ifFail: self ifFailBlock;"
		post;
		response.
	^ self objectJsonMapper readDocument: response contents
visiting
visitGtPubJsonPost: aGtPubJsonPost 
	self entity: (ZnEntity text: (self objectJsonMapper writePost: aGtPubJsonPost)).
	self entity contentType: ZnMimeType applicationJson.
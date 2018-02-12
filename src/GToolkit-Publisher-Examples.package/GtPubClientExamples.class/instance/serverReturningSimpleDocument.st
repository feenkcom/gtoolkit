server - delegate
serverReturningSimpleDocument
	<gtExample>
	<label: 'Server that return an empty document'>
	^ self basicServer delegate
		map: '/publish' to: [ :request :response |
			response entity: ((ZnEntity text: self emptyDocumentJsonString)
				contentType: ZnMimeType applicationJson; yourself) ];
		yourself
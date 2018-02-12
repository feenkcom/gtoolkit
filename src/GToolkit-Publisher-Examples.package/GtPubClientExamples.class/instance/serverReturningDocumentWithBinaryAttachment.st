server - delegate
serverReturningDocumentWithBinaryAttachment
	<gtExample>
	<label: 'Server that return a document with binary attachment'>
	^ self basicServer delegate
		map: '/publish' to: [ :request :response |
			response entity: ((ZnEntity text: self documentWithBinaryAttachmentJsonString)
				contentType: ZnMimeType applicationJson; yourself) ];
		yourself
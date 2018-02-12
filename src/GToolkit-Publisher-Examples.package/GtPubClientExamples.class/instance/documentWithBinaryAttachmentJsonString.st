documents - json
documentWithBinaryAttachmentJsonString
	<gtExample>
	<label: 'JSON of a document with a binary attachment'>
	| json |
	json := self objectJsonMapper writeDocument: self documentWithBinaryAttachment.
	self 
		assert: json 
		equals: '{"id":"document-id","nonce":"Client side internal document id","title":"Title of a document","description":"Description of a document","timestamp":"2018-02-11T22:54:05.709422-03:00","root":"binary-attachment.bin","attachments":[{"id":"attachment-id","filename":"binary-attachment.bin","size":4,"url":"http://localhost:', self serverPort asString, '/cdn/binary-attachment.bin"}]}'.
	^ json
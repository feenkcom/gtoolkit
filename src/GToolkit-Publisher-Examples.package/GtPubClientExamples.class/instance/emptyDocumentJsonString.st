documents - json
emptyDocumentJsonString
	<gtExample>
	<label: 'JSON of an empty document with title and description'>
	| json |
	json := self objectJsonMapper writeDocument: self emptyDocument.
	self 
		assert: json 
		equals: '{"id":"document-id","nonce":"Client side internal document id","title":"Title of a document","description":"Description of a document","timestamp":"2018-02-11T22:54:05.709422-03:00","attachments":[]}'.
	^ json
publish documents
publishDocumentWithBinaryAttachment
	<gtExample>
	<label: 'Publish a document with binary attachment'>
	| document |
	self serverReturningDocumentWithBinaryAttachment.
	document := self postBuilderDocumentWithBinaryAttachment
		restApi: self restApi;
		publish.
	self assertSimpleDocument: document.
	self assert: document attachments size equals: 1.
	^ document

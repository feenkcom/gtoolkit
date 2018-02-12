publish documents
postBuilderSimpleDocument
	<gtExample>
	<label: 'Basic post builder with a simple document'>
	^ self postBuilder
		title: 'Title of a document';
		description: 'Description of a document';
		nonce: 'Client side internal id';
		yourself
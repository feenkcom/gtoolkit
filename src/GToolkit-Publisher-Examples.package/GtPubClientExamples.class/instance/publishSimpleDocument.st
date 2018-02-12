publish documents
publishSimpleDocument
	<gtExample>
	<label: 'Publish a simple document'>
	| document |
	self serverReturningSimpleDocument.
	document := self postBuilderSimpleDocument
		restApi: self restApi;
		publish.
	self assertSimpleDocument: document.
	^ document

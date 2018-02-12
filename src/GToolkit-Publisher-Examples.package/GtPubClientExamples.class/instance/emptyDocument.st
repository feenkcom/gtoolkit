documents - object
emptyDocument
	<gtExample>
	<label: 'Empty document with title and description'>
	| document |
	document := GtPubDocument new
		id: 'document-id';
		title: 'Title of a document';
		description: 'Description of a document';
		nonce: 'Client side internal document id';
		timestamp: '2018-02-11T22:54:05.709422-03:00' asDateAndTime;
		yourself.
	self assert: document id equals: 'document-id'.
	self assert: document title equals: 'Title of a document'.
	self assert: document description equals: 'Description of a document'.
	self assert: document nonce equals: 'Client side internal document id'.
	self assert: document timestamp equals: '2018-02-11T22:54:05.709422-03:00' asDateAndTime.
	self assert: document attachments isEmpty.
	^ document
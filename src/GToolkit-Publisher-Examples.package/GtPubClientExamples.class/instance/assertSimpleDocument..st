asserting
assertSimpleDocument: aGtPubDocument
	self assert: aGtPubDocument id equals: 'document-id'.
	self assert: aGtPubDocument title equals: 'Title of a document'.
	self assert: aGtPubDocument description equals: 'Description of a document'.
	self assert: aGtPubDocument nonce equals: 'Client side internal document id'.
	self assert: aGtPubDocument timestamp equals: '2018-02-11T22:54:05.709422-03:00' asDateAndTime.
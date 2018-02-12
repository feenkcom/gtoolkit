documents - object
emptyAttachment
	<gtExample>
	<label: 'Empty attachment'>
	| attachment |
	attachment := GtPubAttachment new
		id: 'attachment-id';
		yourself.
	self assert: attachment id equals: 'attachment-id'.
	self assert: attachment fileName isNil.
	self assert: attachment fileSize isNil.
	self assert: attachment url isNil.
	^ attachment
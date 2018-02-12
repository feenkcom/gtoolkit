documents - object
documentWithBinaryAttachment
	<gtExample>
	<label: 'Document with a binary attachment'>
	| document attachment |
	attachment := self binaryAttachment.
	document := self emptyDocument
		attachments: { attachment };
		root: attachment fileName;
		yourself.
	self assert: document attachments size equals: 1.
	^ document
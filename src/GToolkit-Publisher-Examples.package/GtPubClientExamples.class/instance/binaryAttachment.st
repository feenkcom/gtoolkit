documents - object
binaryAttachment
	<gtExample>
	<label: 'Attachment including bytes'>
	| attachment |
	attachment := self emptyAttachment
		fileName: 'binary-attachment.bin';
		fileSize: 4;
		url: self cdnUrl / 'binary-attachment.bin';
		yourself.
	self assert: attachment fileName equals: 'binary-attachment.bin'.
	self assert: attachment fileSize equals: 4.
	self assert: attachment url equals: self cdnUrl / 'binary-attachment.bin'.
	^ attachment
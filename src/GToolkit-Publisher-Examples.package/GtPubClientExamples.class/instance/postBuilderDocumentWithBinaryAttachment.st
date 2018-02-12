publish documents
postBuilderDocumentWithBinaryAttachment
	<gtExample>
	<label: 'Basic post builder with document with a binary attachment'>
	^ self postBuilderSimpleDocument
		attachmentNamed: 'binary-attachment.bin' bytes: #[ 1 2 3 4 ]; 
		yourself
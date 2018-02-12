gt-inspector-extension
gtInspectorAttachmentsIn: composite
	<gtInspectorPresentationOrder: 2>
	^ composite fastTable
		title: 'Attachments';
		display: [ self attachments ];
		when: [ self attachments isEmptyOrNil not ];
		column: 'FileName' evaluated: [ :attachment |
			attachment fileName asString ];
		column: 'FileSize' 
			evaluated: [ :attachment |
				attachment fileSize asString ]
			width: 80;
		column: 'URL' evaluated: [ :attachment |
			attachment url asString ];
		yourself
		
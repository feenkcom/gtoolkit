gt-inspector-extension
gtInspectorMimePartsIn: composite
	<gtInspectorPresentationOrder: 2>
	^ composite fastTable 
		title: [ 'MimeParts' translated ];
		display: [ self mimeParts ];
		when: [ self mimeParts isEmptyOrNil not ];
		column: 'FileName' 
			evaluated: [ :part | part fileName ] 
			width: 200;
		column: 'Type' 
			evaluated: [ :part | part contentType ] 
			width: 200;
		column: 'Length' 
			evaluated: [ :part | part contentLength ] 
			width: 80;
		yourself
		
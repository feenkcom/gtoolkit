*GToolkit-Documenter
gtInspectorGtDocumenterParse
	<gtInspectorAction>
	^ GLMGenericAction new
		action:  [ :presentation | self showParsedDocumentIn: presentation ];
		condition: [ self exists and: [ self extension = 'pillar' ] ];
		iconName: #glamorousDiveRight;
		title: 'Parse using GToolkit Documenter' translated;
		yourself
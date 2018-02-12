gt-inspector-extension
gtInspectorContentsIn: composite
	<gtInspectorPresentationOrder: 1>
	^ composite text
		title: 'Contents';
		display: [ self gtPrintContentsString ];
		yourself
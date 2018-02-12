gt-inspector-extension
gtInspectorContentsIn: composite
	<gtInspectorPresentationOrder: 1>
	^ composite text
		title: [ 'Contents' translated ];
		display: [ self gtPrintContentsString ];
		yourself
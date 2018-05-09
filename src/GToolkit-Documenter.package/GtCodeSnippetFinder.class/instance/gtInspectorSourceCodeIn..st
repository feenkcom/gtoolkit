gt-inspector-extension
gtInspectorSourceCodeIn: composite
	<gtInspectorPresentationOrder: -4>
	^ composite text
		title: [ 'Source code' ];
		display: [ self sourceCode ];
		when: [ self tokens notNil ]
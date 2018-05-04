gt-inspector-extension
gtInspectorSourceCodeIn: composite
	<gtInspectorPresentationOrder: -4>
	^ composite text
		title: [ 'Source code' ];
		display: [ self scriptBodyString ];
		when: [ self scriptBodyString notNil ]
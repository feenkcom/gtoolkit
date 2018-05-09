gt-inspector-extension
gtInspectorTargetTextIn: composite
	<gtInspectorPresentationOrder: 2>
	^ composite text 
		title: [ 'Target Text' translated ];
		display: [ self targetText ];
		when: [ self targetText notNil ];
		yourself
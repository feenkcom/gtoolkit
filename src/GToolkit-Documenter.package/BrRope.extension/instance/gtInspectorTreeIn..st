*GToolkit-Documenter
gtInspectorTreeIn: composite
	<gtInspectorPresentationOrder: 10>
	^ composite blocMondrian
		title: 'Tree';
		painting: [ :mondrian :x :presentation | self paintTreeWith: mondrian ]
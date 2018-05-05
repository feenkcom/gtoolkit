gt-inspector-extension
gtInspectorParametersIn: composite
	<gtInspectorPresentationOrder: -2>
	^ parameters ifNotNil: [ :aDictionary |
		(aDictionary gtInspectorItemsIn: composite)
			title: [ 'Parameters' translated ] ]
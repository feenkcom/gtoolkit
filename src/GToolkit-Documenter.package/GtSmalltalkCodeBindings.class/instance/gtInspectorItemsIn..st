gt-inspector-extension
gtInspectorItemsIn: composite
	<gtInspectorPresentationOrder: 1>
	^ bindings ifNotNil: [ :aDictionary |
		(aDictionary gtInspectorItemsIn: composite)
			title: 'Bindings' ]
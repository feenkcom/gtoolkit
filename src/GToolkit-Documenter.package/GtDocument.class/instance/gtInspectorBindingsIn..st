gt-inspector-extension
gtInspectorBindingsIn: composite
	<gtInspectorPresentationOrder: 1>
	^ bindings ifNotNil: [ :aBindings |
		(aBindings gtInspectorItemsIn: composite)
			title: 'Bindings' ]
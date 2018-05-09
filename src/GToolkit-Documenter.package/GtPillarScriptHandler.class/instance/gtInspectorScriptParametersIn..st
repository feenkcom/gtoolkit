gt-inspector-extension
gtInspectorScriptParametersIn: composite
	<gtInspectorPresentationOrder: 1>
	^ self scriptParameters ifNotNil: [ :aDictionary |
		(aDictionary gtInspectorItemsIn: composite)
			title: [ 'Parameters' translated ];
			yourself ]
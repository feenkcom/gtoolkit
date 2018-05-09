gt-inspector-extension
gtInspectorSourceDirectoryIn: composite
	<gtInspectorPresentationOrder: 3>
	^ self sourceDirectory ifNotNil: [ :aFileReference | 
		(aFileReference gtInspectorItemsIn: composite)
			title: [ 'Source Directory' translated ];
			yourself ]
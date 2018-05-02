*GToolkit-Documenter-Epicea
gtInspectorEntriesIn: composite
	<gtInspectorPresentationOrder: 1>
	^ self store ifNotNil: [ :aStore |
		(aStore gtInspectorEntriesIn: composite) ]
GT-Examples-UI
gtInspectorDependenciesIn: composite
	<gtInspectorPresentationOrder: 1>
	^ self dependenciesOrArguments 
		ifEmpty: [ self ] 
		ifNotEmpty: [ :aCollection | 
			(aCollection asOrderedCollection gtInspectorItemsIn: composite)
				title: 'Dependencies' ]
	
	
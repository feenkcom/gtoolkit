gt-inspector-extension
gtInspectorEntriesIn: composite
	<gtInspectorPresentationOrder: 1>
	^ epiceaLog ifNotNil: [ :aLog | 
		(aLog gtInspectorEntriesIn: composite) ]
gt-inspector-extension
gtInspectorEntriesIn: composite
	<gtInspectorPresentationOrder: 1>
	^ theLog ifNotNil: [ :aLog | 
		(aLog gtInspectorEntriesIn: composite)
			title: [ 'Tutorial' translated ];
			updateOn: GtEpiceaImpactChangedAnnouncement from: [ self announcer ];
			selectionAct: [ :aPresentation | 
				self removeSelectedItemsFromPresentation: aPresentation  ] 
				entitled: 'Remove from tutorial' 
				condition: [ true ] ]
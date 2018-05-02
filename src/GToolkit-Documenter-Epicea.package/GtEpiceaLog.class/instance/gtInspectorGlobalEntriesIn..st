gt-inspector-extension
gtInspectorGlobalEntriesIn: composite
	<gtInspectorPresentationOrder: 2>
	^ (EpMonitor current log gtInspectorEntriesIn: composite)
			title: [ 'Global Changes' translated ];
			selectionAct: [ :aPresentation | 
				self insertSelectedItemsFromPresentation: aPresentation  ] 
				entitled: 'Add to tutorial' 
				condition: [ true ]
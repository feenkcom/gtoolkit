Extension { #name : #GtSpotterStart }

{ #category : #'*GToolkit-World' }
GtSpotterStart >> gtSpotterForToolsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		allCandidates: [ 
			{
				GtPlaygroundStencil new 
			}, ((RPackageOrganizer default includesPackageNamed: 'Lepiter-Tool')
				ifTrue: [ {
					LeNotePlaygroundStencil new.
					LeLepiterToolStencil new }]
				ifFalse: [ {} ]),
			{
				GtCoderStencil new . 
				GtMonitorStencil new . 
				GtRlGToolkitExamplesExplorer buildForGToolkitProject . 
				GtGitStencil new . 
				GtTranscriptStencil new .
				GtFileSystemStencil new
			} ];
		previewElement: [ :aStencil | aStencil asPreviewElement asElement ];
		title: 'Tools';
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

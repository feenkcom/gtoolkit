Extension { #name : #GtWorldSpotterSearchStart }

{ #category : #'*GToolkit-World' }
GtWorldSpotterSearchStart >> gtSpotterForToolsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		allCandidates: [ 
			{
				GtPlaygroundStencil new 
					knowledgeBase: self knowledgeBase.
				LeNotePlaygroundStencil new
					knowledgeBase: self knowledgeBase.
				LeLepiterToolStencil new
					knowledgeBase: self knowledgeBase.
				GtCoderStencil new . 
				GtMonitorStencil new . 
				GtRlGToolkitExamplesExplorer buildForGToolkitProject . 
				GtGitStencil new . 
				GtEpiceaStencil new . 
				GtTranscriptStencil new .
				GtFileSystemStencil new
			} ];
		previewElement: [ :aStencil | aStencil asPreviewElement asElement ];
		title: 'Tools';
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

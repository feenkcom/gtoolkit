Extension { #name : 'GtWorldSpotterSearchStart' }

{ #category : '*GToolkit-World' }
GtWorldSpotterSearchStart >> gtSpotterForToolsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		allCandidates: [ 
			{
				GtPlaygroundStencil new 
					knowledgeBase: self knowledgeBase
			}, (GtImage isLepiterEnabled 
					ifTrue: [ {
						LeNotePlaygroundStencil new
							knowledgeBase: self knowledgeBase.
						(LeLepiterToolStencil new
							knowledgeBase: self knowledgeBase) } ]
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

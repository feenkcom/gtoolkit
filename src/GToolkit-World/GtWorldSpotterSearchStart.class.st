Class {
	#name : #GtWorldSpotterSearchStart,
	#superclass : #GtSpotterStart,
	#instVars : [
		'knowledgeBase'
	],
	#category : #'GToolkit-World-Search'
}

{ #category : #searches }
GtWorldSpotterSearchStart >> gtSearchForToolsFor: aSearch [
	<gtSpotterSearch>

	^ aSearch list
		priority: 1;
		items: [ 
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
		title: 'Tools';
		filter: [ GtSpotterSubstringFilter new ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #spotter }
GtWorldSpotterSearchStart >> gtSpotterContainingSubPartsFor: aStep [
	<gtSearch>
	self hasKnowledgeBase ifFalse: [ ^ self ].
	self hasChildren ifFalse: [ ^ self ].
	
	aStep listProcessor
		priority: 23;
		title: 'Pages';
		wantsToDisplayOnEmptyQuery: true;
		filter: LeSubstringFilter
			item: [ :filter :context | 
				self knowledgeBase pagesWithNameDo: filter.
				self knowledgeBase unnamedPagesDo: filter ];
		itemName: #spotterItemName
]

{ #category : #spotter }
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

{ #category : #spotter }
GtWorldSpotterSearchStart >> gtSpotterNewPageFor: aStep [
	<gtSearch>
	self hasKnowledgeBase ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'New Page';
		priority: 50;
		itemName: [ :aPageTitle | 'Create new page: ', aPageTitle ];
		previewObject: [ :aPageTitle | LePage named: aPageTitle ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExistingPage |
				isExistingPage := self knowledgeBase pagesByName anySatisfy: [ :eachPage | 
					eachPage title = context textTrimmed ].
				isExistingPage ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :aPageTitle :spotterStep | self knowledgeBase addPage: (LePage named: aPageTitle) ]
]

{ #category : #spotter }
GtWorldSpotterSearchStart >> gtSpotterPageTitlesFor: aStep [
	<gtSearch>
	self hasKnowledgeBase ifFalse: [ ^ self ].
	self hasChildren ifFalse: [ ^ self ].
	
	aStep listProcessor
		title: 'Page Names';
		priority: 22;
		filter: GtFilterSubstring
			item: [ :filter :context | 
				self knowledgeBase pagesWithNameDo: filter ];
		itemName: #title;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #testing }
GtWorldSpotterSearchStart >> hasChildren [
	self knowledgeBase ifNil: [ ^ false ].
	^ self knowledgeBase hasChildren
]

{ #category : #testing }
GtWorldSpotterSearchStart >> hasKnowledgeBase [
	^ self knowledgeBase notNil
]

{ #category : #accessing }
GtWorldSpotterSearchStart >> knowledgeBase [
	^ knowledgeBase
]

{ #category : #accessing }
GtWorldSpotterSearchStart >> knowledgeBase: aKnowledgeBase [
	knowledgeBase := aKnowledgeBase
]

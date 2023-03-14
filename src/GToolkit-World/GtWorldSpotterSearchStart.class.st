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
	<gtSearch>
	^ aSearch list
		priority: 1;
		items: [ {GtPlaygroundStencil new knowledgeBase: self knowledgeBase.
				LeNotePlaygroundStencil new knowledgeBase: self knowledgeBase.
				LeLepiterToolStencil new knowledgeBase: self knowledgeBase.
				GtCoderStencil new.
				GtMonitorStencil new.
				GtRlGToolkitExamplesExplorer buildForGToolkitProject.
				GtGitStencil new.
				GtEpiceaStencil new.
				GtTranscriptStencil new.
				GtFileSystemStencil new} ];
		title: 'Tools';
		filterBySubstring;
		previewElement: [ :aStencil | aStencil asPreviewElement asElement ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #searches }
GtWorldSpotterSearchStart >> gtSearchPagesByTitleFor: aSearch [
	<gtSearch>
	self hasKnowledgeBase ifFalse: [ ^ aSearch empty ].
	self hasChildren ifFalse: [ ^ aSearch empty ].

	^ aSearch explicit
		title: 'Named pages';
		priority: 22;
		search: [ :aContext | self knowledgeBase asyncPagesForWord: aContext searchQuery ];
		itemName: #title;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtWorldSpotterSearchStart >> gtSpotterContainingSubPartsFor: aSearch [
	<gtSearch>
	self hasKnowledgeBase
		ifFalse: [ ^ aSearch empty ].
	self hasChildren
		ifFalse: [ ^ aSearch empty ].
	
	^ aSearch explicit
		priority: 23;
		title: 'Page contents';
		search: [ :aContext |
			[
			| filter results |
			results := OrderedCollection new.
			filter := LeSubstringFilter new
				caseSensitive: false;
				query: aContext searchQuery.
			self knowledgeBase pagesWithNameDo: [ :eachPage |
				(filter isMatchedItem: eachPage)
					ifTrue: [ results add: eachPage ] ].
			self knowledgeBase unnamedPagesDo: [ :eachPage |
				(filter isMatchedItem: eachPage)
					ifTrue: [ results add: eachPage ] ].
			results asAsyncStream
			] asAsyncFuture asAsyncStream flatten
		];
		itemName: #spotterItemName
]

{ #category : #spotter }
GtWorldSpotterSearchStart >> gtSpotterNewPageFor: aStep [
	"<gtSearch>"
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

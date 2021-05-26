Class {
	#name : #GtWorldSpotterSearchStart,
	#superclass : #GtSpotterStart,
	#instVars : [
		'knowledgeBaseComputation'
	],
	#category : #'GToolkit-World-Search'
}

{ #category : #'gt-extensions' }
GtWorldSpotterSearchStart >> gtSpotterContainingSubPartsFor: aStep [
	<gtSearch>
	self hasChildren ifNil: [ ^ self ].
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

{ #category : #'gt-extensions' }
GtWorldSpotterSearchStart >> gtSpotterNewPageFor: aStep [
	"A new page is added in ${method:LeWorldElement>>#newSpotterButton}$"
	<gtSearch>
	aStep listProcessor
		title: 'New Page';
		priority: 50;
		itemName: [ :aPageTitle | 'Create new page: ', aPageTitle ];
		previewObject: [ :aPageTitle | 
			self knowledgeBase pageBuilder title: aPageTitle; build ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExistingPage |
				isExistingPage := self knowledgeBase pagesByName anySatisfy: [ :eachPage | 
					eachPage title = context textTrimmed ].
				isExistingPage ifFalse: [ 
					filter value: context textTrimmed ] ]
]

{ #category : #'gt-extensions' }
GtWorldSpotterSearchStart >> gtSpotterPageTitlesFor: aStep [
	<gtSearch>
	self hasChildren ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Page Names';
		priority: 30;
		filter: GtFilterSubstring
			item: [ :filter :context | 
				self knowledgeBase pagesWithNameDo: filter ];
		itemName: #title;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #testing }
GtWorldSpotterSearchStart >> hasChildren [
	^ self knowledgeBase hasChildren
]

{ #category : #accessing }
GtWorldSpotterSearchStart >> knowledgeBase [
	^ knowledgeBaseComputation value 
]

{ #category : #accessing }
GtWorldSpotterSearchStart >> knowledgeBase: aValuable [
	knowledgeBaseComputation := aValuable
]

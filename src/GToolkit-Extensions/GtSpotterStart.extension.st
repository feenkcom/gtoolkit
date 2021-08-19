Extension { #name : 'GtSpotterStart' }

{ #category : '*GToolkit-Extensions' }
GtSpotterStart >> spotterForColorFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Color';
		priority: 100;
		allCandidates: [ Color gtRegisteredColors ];
		itemName: #name;
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

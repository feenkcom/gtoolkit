Extension { #name : #BlInfiniteRecyclerFetcherResult }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResult >> gtFetcherSteps [
	^ #()
]

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResult >> gtFetcherStepsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Steps';
		priority: 5;
		items: [ self gtFetcherSteps ];
		children: #gtFetcherSteps;
		expandAll;
		column: 'Fetcher' text: #gtDescription
]

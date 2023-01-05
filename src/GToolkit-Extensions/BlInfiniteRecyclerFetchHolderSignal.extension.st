Extension { #name : #BlInfiniteRecyclerFetchHolderSignal }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetchHolderSignal >> gtFetcherStepsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Steps';
		priority: 0.5;
		object: [ fetcherResult ];
		view: #gtFetcherStepsFor:
]

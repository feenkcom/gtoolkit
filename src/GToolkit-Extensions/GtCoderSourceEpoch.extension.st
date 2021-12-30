Extension { #name : #GtCoderSourceEpoch }

{ #category : #'*GToolkit-Extensions' }
GtCoderSourceEpoch >> gtEpochFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Timestamp';
		priority: 10;
		object: [ timestamp ];
		view: #gtViewDetailsIn:
]

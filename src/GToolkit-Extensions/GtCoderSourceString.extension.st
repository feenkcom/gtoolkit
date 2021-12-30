Extension { #name : #GtCoderSourceString }

{ #category : #'*GToolkit-Extensions' }
GtCoderSourceString >> gtEpochFor: aView [
	<gtView>

	^ aView forward
		title: 'Epoch' translated;
		priority: 11;
		object: [ self epoch ];
		view: #gtEpochFor:
]

{ #category : #'*GToolkit-Extensions' }
GtCoderSourceString >> gtStringFor: aView [
	<gtView>

	^ aView forward
		title: 'String' translated;
		priority: 10;
		object: [ self string ];
		view: #gtStringFor:
]

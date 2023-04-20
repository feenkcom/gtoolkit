Extension { #name : #AsyncStreamTransitionBuffer }

{ #category : #'*GToolkit-Extensions' }
AsyncStreamTransitionBuffer >> gtBufferedItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'New Buffer Items';
		priority: 5;
		object: [ newBuffer ];
		view: #gtBufferedItemsFor:
]

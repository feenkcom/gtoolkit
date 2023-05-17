Extension { #name : #AsyncStreamTransitionBuffer }

{ #category : #'*GToolkit-Extensions' }
AsyncStreamTransitionBuffer >> gtBufferedItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'New buffer items';
		priority: 5;
		object: [ newBuffer ];
		view: #gtBufferedItemsFor:
]

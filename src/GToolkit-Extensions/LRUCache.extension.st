Extension { #name : #LRUCache }

{ #category : #'*GToolkit-Extensions' }
LRUCache >> gtViewItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'Items';
		object: lruList;
		view: #gtViewItemsFor:
]

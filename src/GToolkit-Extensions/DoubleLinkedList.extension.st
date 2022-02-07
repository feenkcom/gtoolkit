Extension { #name : #DoubleLinkedList }

{ #category : #'*GToolkit-Extensions' }
DoubleLinkedList >> gtViewItemsFor: aView [
	<gtView>
	^ aView list
		title: 'Items';
		items: [ self asArray ]
]

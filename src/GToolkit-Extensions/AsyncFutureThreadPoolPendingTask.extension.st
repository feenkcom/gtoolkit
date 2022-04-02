Extension { #name : #AsyncFutureThreadPoolPendingTask }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtCompositionChildren [
	^ { task }
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtCompositionDescription [
	^ self printString
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtCompositionFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Composition';
		  items: [ { self } ];
		  children: #gtCompositionChildren;
		  expandAll;
		  column: 'Name' text: #gtCompositionDescription;
		  actionUpdateButtonTooltip: 'Update composition tree'
]

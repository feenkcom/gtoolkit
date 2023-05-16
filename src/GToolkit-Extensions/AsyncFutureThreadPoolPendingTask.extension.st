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

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtTaskFullPromiseTreeFor: aView [
	<gtView>
	
	task ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Full tree';
		priority: 10;
		object: [ task ];
		view: #gtFullPromiseTreeFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtTaskPromiseFor: aView [
	<gtView>
	
	task ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Task promise';
		priority: 1;
		object: [ task ];
		view: #gtPromiseFor:
]

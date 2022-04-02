Extension { #name : #AsyncFutureThreadPoolPendingTask }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtTaskFullPromiseTreeFor: aView [
	<gtView>
	
	task ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Full Tree';
		priority: 10;
		object: [ task ];
		view: #gtFullPromiseTreeFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolPendingTask >> gtTaskPromiseFor: aView [
	<gtView>
	
	task ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Task Promise';
		priority: 1;
		object: [ task ];
		view: #gtPromiseFor:
]

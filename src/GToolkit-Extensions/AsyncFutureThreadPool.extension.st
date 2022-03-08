Extension { #name : #AsyncFutureThreadPool }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPool >> gtWorkersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Workers';
		priority: 10;
		items: [ workers asArray withIndexCollect: [ :each :index | each -> index ] ];
		column: 'Worker' text: [ :each | each value ];
		column: 'Tasks' text: [ :each | each key amountOfFutures ];
		column: 'Pending' text: [ :each | each key pendingQueueSize ];
		column: 'Busy' text: [ :each | each key isBusy ];
		column: 'Running' text: [ :each | each key isRunning ];
		send: [ :each | each key ];
		actionUpdateButton
]

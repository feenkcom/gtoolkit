Extension { #name : #BlSpaceTaskQueue }

{ #category : #'*GToolkit-Extensions' }
BlSpaceTaskQueue >> gtPendingTasksFor: aView [
	<gtView>
	tasks lock: [ :theTasks | theTasks ifNil: [ ^ aView empty ] ].

	^ aView forward
		title: 'Pending Tasks';
		priority: 1;
		object: [ tasks lock: [ :theTasks | theTasks ] ];
		view: #gtPendingTasksFor:
]

{ #category : #'*GToolkit-Extensions' }
BlSpaceTaskQueue >> gtTasksAtQueueFor: aView [
	<gtView>
	self taskAtQueue ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Tasks At Queue';
		priority: 3;
		object: [ self taskAtQueue ];
		view: #gtItemsFor:;
		actionUpdateButtonTooltip: 'Update task list'
]

{ #category : #'*GToolkit-Extensions' }
BlSpaceTaskQueue >> gtTasksFor: aView [
	<gtView>
	tasks lock: [ :theTasks | theTasks ifNil: [ ^ aView empty ] ].

	^ aView forward
		title: 'Active Tasks';
		priority: 2;
		object: [ tasks lock: [ :theTasks | theTasks ] ];
		view: #gtActiveTasksFor:
]

Extension { #name : #BlSpaceTasksCollection }

{ #category : #'*GToolkit-Extensions' }
BlSpaceTasksCollection >> gtActiveTasksFor: aView [
	<gtView>
	activeTasks ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Active Tasks';
		priority: 2;
		object: [ activeTasks ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
BlSpaceTasksCollection >> gtPendingTasksFor: aView [
	<gtView>
	pendingTasks ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Pending Tasks';
		priority: 1;
		object: [ pendingTasks ];
		view: #gtItemsFor:
]

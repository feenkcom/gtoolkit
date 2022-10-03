Extension { #name : #BlSpaceTaskQueue }

{ #category : #'*GToolkit-Extensions' }
BlSpaceTaskQueue >> gtTasksAtQueueFor: aView [
	<gtView>
	self taskAtQueue ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Tasks At Queue';
		priority: 2;
		object: [ self taskAtQueue ];
		view: #gtItemsFor:;
		actionUpdateButtonTooltip: 'Update task list'
]

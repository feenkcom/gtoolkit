Extension { #name : #BlTaskQueue }

{ #category : #'*GToolkit-Extensions' }
BlTaskQueue >> gtTasksFor: aView [
	<gtView>
	^ aView list
		title: 'Tasks';
		priority: 1;
		items: [ self tasks ifNil: [ #() ] ];
		actionUpdateButtonTooltip: 'Update task list'
]

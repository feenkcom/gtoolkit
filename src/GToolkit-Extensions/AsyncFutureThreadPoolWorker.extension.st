Extension { #name : #AsyncFutureThreadPoolWorker }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtLocalQueueFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Local queue';
		priority: 11;
		object: [ localQueue ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtPendingQueueFor: aView [
	<gtView>

	^ aView forward
		title: 'Pending queue';
		priority: 12;
		object: [ pendingQueue ];
		view: #gtItemsFor:;
		actionButtonIcon: BrGlamorousVectorIcons cancel
			tooltip: 'Cancel pending tasks'
			action: [ :aButton :aTab |
				pendingQueue itemArray do: [ :each | each task cancelSoft ].
				aTab viewContentElement phlow update ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPoolWorker >> gtShutdownActionFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Shutdown';
		priority: 30;
		icon: BrGlamorousVectorIcons shutdown;
		action: [ self shutdown ]
]

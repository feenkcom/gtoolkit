Extension { #name : #BlScripter }

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtSpaceActiveTasksFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self space taskQueue isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Active Space Tasks';
		priority: 41;
		object: [ self space taskQueue ];
		view: #gtTasksFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Task Queue'
			tooltip: 'Inspect space task queue'
			action: [ :aButton | aButton phlow spawn: self space taskQueue ]
]

{ #category : #'*GToolkit-Extensions' }
BlScripter >> gtSpacePendingTasksFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self space taskQueue isEmpty ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Pending Space Tasks';
		priority: 40;
		object: [ self space taskQueue ];
		view: #gtPendingTasksFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Task Queue'
			tooltip: 'Inspect space task queue'
			action: [ :aButton | aButton phlow spawn: self space taskQueue ]
]

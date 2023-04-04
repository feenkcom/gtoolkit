Extension { #name : #BrElementUpdaterSignal }

{ #category : #'*GToolkit-Extensions' }
BrElementUpdaterSignal >> gtActionMethodFor: aView [
	<gtView>
	self updater ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Updating Method';
		object: [ self updater ];
		view: #gtActionMethodFor:
]

{ #category : #'*GToolkit-Extensions' }
BrElementUpdaterSignal >> gtPreviewFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Element';
		priority: 0;
		object: [ self element ];
		view: #gtPreviewFor:
]

Extension { #name : #MAActionDescription }

{ #category : #'*GToolkit-Extensions' }
MAActionDescription >> gtSourceFor: aView [
	<gtView>
	self definingSource ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self definingSource ];
		view: #gtSourceFor:
]

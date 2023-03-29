Extension { #name : #MADescription }

{ #category : #'*GToolkit-Extensions' }
MADescription >> gtSourceFor: aView [
	<gtView>
	self definingSource ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self definingSource ];
		view: #gtSourceFor:
]

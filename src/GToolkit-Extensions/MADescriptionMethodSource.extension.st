Extension { #name : #MADescriptionMethodSource }

{ #category : #'*GToolkit-Extensions' }
MADescriptionMethodSource >> gtSourceFor: aView [
	<gtView>
	self compiledMethod ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 1;
		object: [ self compiledMethod ];
		view: #gtSourceFor:
]

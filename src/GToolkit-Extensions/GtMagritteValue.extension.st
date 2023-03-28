Extension { #name : #GtMagritteValue }

{ #category : #'*GToolkit-Extensions' }
GtMagritteValue >> gtSourceFor: aView [
	<gtView>
	self description ifNil: [ ^ aView empty ].
	self description definingSource ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self description ];
		view: #gtSourceFor:
]

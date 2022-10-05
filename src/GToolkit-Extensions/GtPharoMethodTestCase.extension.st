Extension { #name : #GtPharoMethodTestCase }

{ #category : #'*GToolkit-Extensions' }
GtPharoMethodTestCase >> gtResultsFor: aView [
	<gtView>
	self hasResult ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Results';
		priority: 1;
		object: [ self result ];
		view: #gtResultsFor:
]

{ #category : #'*GToolkit-Extensions' }
GtPharoMethodTestCase >> gtSourceFor: aView [
	<gtView>
	self compiledMethod ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 2;
		object: [ self compiledMethod ];
		view: #gtSourceFor:
]

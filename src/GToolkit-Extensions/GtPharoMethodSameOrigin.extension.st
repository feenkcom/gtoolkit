Extension { #name : #GtPharoMethodSameOrigin }

{ #category : #'*GToolkit-Extensions' }
GtPharoMethodSameOrigin >> gtSourceFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Source';
		priority: 10;
		object: [ method ];
		view: #gtSourceFor:
]

Extension { #name : #GtPharoMethodTraitOrigin }

{ #category : #'*GToolkit-Extensions' }
GtPharoMethodTraitOrigin >> gtSourceFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Source';
		priority: 10;
		object: [ method ];
		view: #gtSourceFor:
]

Extension { #name : 'ZnOptions' }

{ #category : '*GToolkit-Extensions' }
ZnOptions >> gtBindingsFor: aView [
	<gtView>
	^ aView forward 
		title: 'Bindings';
		priority: 1;
		object: [ self allBindings ];
		view: #gtTreeFor:
]

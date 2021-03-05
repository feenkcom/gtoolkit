Extension { #name : #PragmaCollector }

{ #category : #'*GToolkit-Extensions' }
PragmaCollector >> gtCollectedFor: aView [
	<gtView>
	collected ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Pragmas';
		tooltip: 'Collected pragmas';
		object: [ self collected ];
		view: #gtItemsFor:
]

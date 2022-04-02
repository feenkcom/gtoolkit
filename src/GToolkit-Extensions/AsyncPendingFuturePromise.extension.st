Extension { #name : #AsyncPendingFuturePromise }

{ #category : #'*GToolkit-Extensions' }
AsyncPendingFuturePromise >> gtCompositionFor: aView [
	<gtView>
	
	future ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Future Composition';
		object: [ future ];
		view: #gtCompositionFor:
]

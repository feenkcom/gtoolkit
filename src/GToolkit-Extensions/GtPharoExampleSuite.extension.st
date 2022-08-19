Extension { #name : #GtPharoExampleSuite }

{ #category : #'*GToolkit-Extensions' }
GtPharoExampleSuite >> gtExamplesCacheFor: aView [
	<gtView>
	examplesCache ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Examples Cache';
		priority: 1;
		object: [ examplesCache ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
GtPharoExampleSuite >> gtExamplesWithResultCacheFor: aView [
	<gtView>
	examplesWithResultCache ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Examples With Result Cache';
		priority: 2;
		object: [ examplesWithResultCache ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
GtPharoExampleSuite >> gtExamplesWithResultStreamFor: aView [
	<gtView>
	examplesWithResultStream ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Examples With Result Stream';
		priority: 3;
		object: [ examplesWithResultStream ];
		view: #gtLiveFor:
]

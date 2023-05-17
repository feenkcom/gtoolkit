Extension { #name : #AsyncFulfilledPromise }

{ #category : #'*GToolkit-Extensions' }
AsyncFulfilledPromise >> gtFullPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Full tree';
		priority: 3;
		painting: [ :aMondrian | self gtPaintFullTreeOn: aMondrian ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncFulfilledPromise >> gtPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Promise tree';
		priority: 2;
		painting: [ :aMondrian | self gtPaintTreeWith: aMondrian ]
]

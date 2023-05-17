Extension { #name : #AsyncRejectedPromise }

{ #category : #'*GToolkit-Extensions' }
AsyncRejectedPromise >> gtFullPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Full tree';
		priority: 3;
		painting: [ :aMondrian | self gtPaintFullTreeOn: aMondrian ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncRejectedPromise >> gtPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Promise tree';
		priority: 2;
		painting: [ :aMondrian | self gtPaintTreeWith: aMondrian ]
]

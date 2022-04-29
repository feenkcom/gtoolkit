Extension { #name : #StandardOrderedDictionary }

{ #category : #'*GToolkit-Extensions' }
StandardOrderedDictionary >> gtKeysFor: aView [

	<gtView>
	^ aView list
		  title: 'Keys';
		  priority: 5;
		  items: [ self keys ]
]

Extension { #name : #Protocol }

{ #category : #'*GToolkit-Extensions' }
Protocol >> gtMethodSelectorsFor: aView [
	<gtView>
	self methodSelectors ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Selectors';
		items: [ self methodSelectors asSortedCollection ]
]

Extension { #name : #GtSmaCCStylerRule }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCStylerRule >> gtStyleBlockFor: aView [
	<gtView>
	self styleBlock ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Style Block';
		object: [ self styleBlock ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
GtSmaCCStylerRule >> gtStylerRulesViewDescriptionText [
	^ ''
]

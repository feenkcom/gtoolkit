Extension { #name : #Message }

{ #category : #'*GToolkit-Extensions' }
Message >> gtAllImplementorsFor: aView [

	<gtView>
	self selector ifNil: [ ^ aView empty ].
	^ aView explicit
		  title: 'Implementors';
		  priority: 1;
		  stencil: [ self selector gtImplementors ]
]

Extension { #name : #SmaCCScanner }

{ #category : #'*GToolkit-Extensions' }
SmaCCScanner >> gtStreamStateFor: aView [
	<gtView>
	self stream ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stream';
		object: [ self stream ];
		view: #gtStreamStateFor:
]

Extension { #name : #SmaCCParser }

{ #category : #'*GToolkit-Extensions' }
SmaCCParser >> gtScannerStreamStateFor: aView [
	<gtView>
	self scanner ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stream';
		object: [ self scanner ];
		view: #gtStreamStateFor:
]

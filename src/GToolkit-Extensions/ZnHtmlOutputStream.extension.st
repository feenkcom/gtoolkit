Extension { #name : #ZnHtmlOutputStream }

{ #category : #'*GToolkit-Extensions' }
ZnHtmlOutputStream >> gtStreamStateFor: aView [
	<gtView>
	stream ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stream';
		object: [ stream ];
		view: #gtStreamStateFor:
]

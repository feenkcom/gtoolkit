Extension { #name : #BlBasicShortcut }

{ #category : #'*GToolkit-Extensions' }
BlBasicShortcut >> gtCombinationFor: aView [
	<gtView>
	self combination ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Combination';
		object: [ self combination ];
		view: #gtPreviewFor:
]

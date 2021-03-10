Extension { #name : #RemoteString }

{ #category : #'*GToolkit-Extensions' }
RemoteString >> gtStringFor: aView [
	<gtView>
	self sourceFileNumber ifNil: [ ^ aView empty ].
	filePositionHi ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'String';
		object: [ self string ];
		view: #gtLiveFor:
]

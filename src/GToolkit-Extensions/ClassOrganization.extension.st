Extension { #name : #ClassOrganization }

{ #category : #'*GToolkit-Extensions' }
ClassOrganization >> gtClassCommentFor: aView [
	<gtView>
	self commentRemoteString ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Comment';
		priority: 2;
		object: [ self commentRemoteString ];
		view: #gtStringFor:
]

{ #category : #'*GToolkit-Extensions' }
ClassOrganization >> gtProtocolsFor: aView [
	<gtView>
	self protocolOrganizer ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Protocols';
		priority: 2;
		object: [ self protocolOrganizer ];
		view: #gtAllProtocolsFor:
]

Extension { #name : #ProtocolOrganizer }

{ #category : #'*GToolkit-Extensions' }
ProtocolOrganizer >> gtAllProtocolsFor: aView [
	<gtView>
	allProtocol ifNil: [ ^ aView empty ].
	protocols ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Protocols';
		priority: 1;
		items: [ self allProtocols ];
		children: [ :each | 
			each isString 
				ifTrue: [ Array empty ]
				ifFalse: [ each methodSelectors ] ]
]

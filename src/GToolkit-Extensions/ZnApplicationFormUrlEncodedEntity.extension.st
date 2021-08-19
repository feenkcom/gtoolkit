Extension { #name : 'ZnApplicationFormUrlEncodedEntity' }

{ #category : '*GToolkit-Extensions' }
ZnApplicationFormUrlEncodedEntity >> gtFieldsFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Fields';
		priority: 1;
		items: [ self fields associations ];
		column: 'Key' item: #key;
		column: 'Value' item: #value weight: 3;
		send: #value
]

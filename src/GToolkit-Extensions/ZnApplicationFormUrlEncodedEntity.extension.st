Extension { #name : 'ZnApplicationFormUrlEncodedEntity' }

{ #category : '*GToolkit-Extensions' }
ZnApplicationFormUrlEncodedEntity >> gtFieldsFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Fields';
		priority: 1;
		items: [ self fields associations ];
		column: 'Key' text: #key;
		column: 'Value' text: #value weight: 3;
		send: #value
]

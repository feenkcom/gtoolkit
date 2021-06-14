Extension { #name : #Color }

{ #category : #'*GToolkit-Extensions' }
Color class >> gtRegisteredColorsFor: aView [
	<gtView>
	<gtClassView>
	
	ColorRegistry ifNil: [ ^ aView empty ].
	
	^ aView columnedList 
		title: 'Registered Colors';
		items: [ ColorRegistry associations sort: [ :a :b | 
				a value red < b value red and: [ 
					a value green < b value green and: [ 
						a value blue < b value blue ] ] ] ];
		actionUpdateButton;
		column: 'Icon' icon: [ :anAssoc | BlElement new background: anAssoc value; size: 16@16 ];
		column: 'Name' item: #value;
		send: #value
]

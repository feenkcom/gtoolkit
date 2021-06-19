Extension { #name : #Color }

{ #category : #'*GToolkit-Extensions' }
Color class >> gtRegisteredColors [
	^ ColorRegistry associations
		collect: [ :anAssoc | GtColorPreview new
			name: anAssoc key;
			color: anAssoc value ]
]

{ #category : #'*GToolkit-Extensions' }
Color class >> gtRegisteredColorsFor: aView [
	<gtView>
	<gtClassView>
	
	ColorRegistry ifNil: [ ^ aView empty ].
	
	^ aView columnedList 
		title: 'Registered Colors';
		items: [ self gtRegisteredColors
			sort: [ :a :b | a < b ] ];
		actionUpdateButton;
		column: 'Icon' icon: [ :aColorHolder | 
			BlElement new background: aColorHolder color; size: 16@16 ];
		column: 'Name' item: #name;
		send: #color
]

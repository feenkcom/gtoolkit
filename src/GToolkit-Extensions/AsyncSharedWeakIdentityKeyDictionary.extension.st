Extension { #name : #AsyncSharedWeakIdentityKeyDictionary }

{ #category : #'*GToolkit-Extensions' }
AsyncSharedWeakIdentityKeyDictionary >> gtItemsFor: aView [
	<gtView>
	dictionary ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Items';
		priority: 1;
		items: [ monitor critical: [ dictionary copy associations ] ];
		column: '' text: [ :_ :anIndex | anIndex ] width: 30;
		column: 'Key'
			stencil: [ :anAssoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					fitContent;
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect key';
					action: [ :aButton | aButton phlow spawnObject: anAssoc key ] ] width: 35;
		column: '' text: #key;
		column: 'Value'
			stencil: [ :anAssoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					fitContent;
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect value';
					action: [ :aButton | aButton phlow spawnObject: anAssoc value ] ] width: 35;
		column: '' text: #value;
		send: #value;
		actionUpdateButton
]

Extension { #name : #SessionManager }

{ #category : #'*GToolkit-Extensions' }
SessionManager >> gtStartupListWithDetails [
	^ (categories flatCollect: [ :aCategory |
			aCategory gtPrioritizedListWithPriority collect: [ :assoc |
				{ aCategory . assoc key. assoc value } ] ]) asArray
]

{ #category : #'*GToolkit-Extensions' }
SessionManager >> gtViewSessionCategoriesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Categories';
		priority: 10;
		items: [ categories ];
		column: 'Category' text: [ :each | each name ];
		column: 'Handlers Count' text: [ :each | each prioritizedList size ] width: 200
]

{ #category : #'*GToolkit-Extensions' }
SessionManager >> gtViewShutdownListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Shutdow List';
		priority: 25;
		items: [ 
			self gtStartupListWithDetails  reversed ];
		column: 'Category' text: [ :data | data first name ] width: 120;
		column: 'Priority' text: [ :data | data second ] width: 150;
		column: 'Handler' text: [ :data | data third ];
		send: [ :data | data third ]
]

{ #category : #'*GToolkit-Extensions' }
SessionManager >> gtViewStartupListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Startup List';
		priority: 20;
		items: [ 
			self gtStartupListWithDetails ];
		column: 'Category' 
			text: [ :data | data first name ]
			width: 120;
		column: 'Priority' text: [ :data | data second ] width: 150;
		column: 'Handler' text: [ :data | data third ];
		send: [ :data | data third ]
]

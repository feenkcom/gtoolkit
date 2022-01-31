Extension { #name : #Pragma }

{ #category : #'*GToolkit-Extensions' }
Pragma class >> gtAnnotatedMethodsFor: aView [

	<gtClassView>
	^ aView columnedList
		  title: 'All Pragmas';
		  priority: 30;
		  items: [ 
			  | pragmas |
			  pragmas := OrderedCollection new.
			  Object withAllSubclassesDo: [ :each | 
					  each pragmasDo: [ :p | pragmas add: p ] ].
			  (pragmas groupedBy: #selector) associations sorted: [ :a :b | 
					  a key < b key ] ];
		  column: 'Keyword' text: [ :each | each key ];
		  column: 'Instances' text: [ :each | each value size asString ];
		  send: #value
]

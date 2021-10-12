Extension { #name : #TestResult }

{ #category : #'*GToolkit-Extensions' }
TestResult >> gtResultsFor: aView [

	<gtView>
	^ aView tree
		  title: 'Results';
		  priority: 1;
		  items: [ #( #passed #failures #errors #skipped ) ];
		  children: [ :anItem | 
		  	anItem isSymbol 
		  		ifTrue: [ self perform: anItem ]
		  		ifFalse: [ #() ] ];
		  expandAll;
		  send: [ :anItem | 
		  	anItem isSymbol 
		  		ifTrue: [ self perform: anItem ]
		  		ifFalse: [ anItem ] ]
]

Extension { #name : #TestSuite }

{ #category : #'*GToolkit-Extensions' }
TestSuite >> gtMethodsFor: aView [

	<gtView>
	^ aView explicit
		  title: 'Methods';
		  priority: 1;
		  stencil: [
			  GtPharoMethodsCoder forItems: self gtAllCompiledMethods ]
]

{ #category : #'*GToolkit-Extensions' }
TestSuite >> gtTestsChildren [

	^ self tests
]

{ #category : #'*GToolkit-Extensions' }
TestSuite >> gtTestsFor: aView [

	<gtView>
	tests ifNil: [ ^ aView empty ].

	^ aView columnedTree
		  title: 'Tests';
		  priority: 2;
		  items: [ self tests ];
		  children: #gtTestsChildren;
		  expandAll;
		  column: 'Test' text: [ :anItem | anItem ]
]

Extension { #name : #TestCase }

{ #category : #'*GToolkit-Extensions' }
TestCase >> gtTestMethodFor: aView [

	<gtView>
	self selector ifNil: [ ^ aView empty ].

	^ aView explicit
		  title: 'Method';
		  priority: 1;
		  stencil: [ 
			  | aCompiledMethod aCoder |
			  aCompiledMethod := self gtCompiledMethod.
			  aCoder := aCompiledMethod
				            ifNil: [ GtPharoMethodCoder new ]
				            ifNotNil: [ 
					            GtPharoMethodCoder forMethod: aCompiledMethod ].
			  (aCoder asCoderUIModel selfObject: self) asExpandedOnlyElement
				  vFitContentLimited ]
]

{ #category : #'*GToolkit-Extensions' }
TestCase >> gtTestsChildren [
	^ #()
]

{ #category : #'*GToolkit-Extensions' }
TestCase class >> gtTestsFor: aView [

	<gtView>
	<gtClassView>
	| aMethodsCoder |
	aMethodsCoder := (GtSearchClassTestSuiteFilter new testCaseClass:
		                  self) asCoder.
	^ aView explicit
		  title: 'Tests';
		  priority: 20;
		  stencil: [ aMethodsCoder ];
		  actionStencil: [ 
			  self newTestSuiteButtonForMethodsCoder: aMethodsCoder ]
]

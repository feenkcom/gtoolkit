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
			  (aCoder asCoderViewModel selfObject: self) asExpandedOnlyElement
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
	| aMethodsCoder aTestSuiteViewModel aSuiteModel aMethodsCoderViewModel |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: self.

	aMethodsCoderViewModel := GtPharoStreamingMethodsCoderViewModel new.
	aMethodsCoderViewModel
		streamingCodersModel: aMethodsCoder;
		shouldExpandByDefault: false;
		shouldHaveHeaderByDefault: false.

	aSuiteModel := GtPharoTestSuite forStream: aMethodsCoder itemsStream.
	aTestSuiteViewModel := GtPharoTestSuiteViewModel new.
	aTestSuiteViewModel
		pharoTestSuite: aSuiteModel;
		when: GtPharoSuiteSelectedStateChanged do: [ :anEvent | 
			aMethodsCoder additionalFilters: (GtPharoTestCaseStateFilter new
						 resultState: anEvent state;
						 pharoTestSuite: aSuiteModel) ].

	^ aView explicit
		  title: 'Tests';
		  priority: 20;
		  stencil: [ 
			  GtPharoStreamingMethodsCoderElement new 
				  streamingCodersViewModel: aMethodsCoderViewModel ];
		  actionStencil: [ 
			  GtPharoCoderUIUtility newTestsDropdownButtonForViewModel:
					  aTestSuiteViewModel ]
]

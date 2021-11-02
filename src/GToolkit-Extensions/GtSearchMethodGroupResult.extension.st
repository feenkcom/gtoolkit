Extension { #name : #GtSearchMethodGroupResult }

{ #category : #'*GToolkit-Extensions' }
GtSearchMethodGroupResult >> gtItemsFor: aView [

	<gtView>
	| aMethodsCoder aTestSuiteViewModel anExampleViewModel |
	aMethodsCoder := self asCoder.
	aTestSuiteViewModel := GtPharoTestSuiteViewModel new 
		                       methodsCoderModel: aMethodsCoder.

	anExampleViewModel := GtPharoExampleSuiteViewModel new 
		                      methodsCoderModel: aMethodsCoder.

	^ aView explicit
		  title: 'Live' translated;
		  priority: 10;
		  stencil: [ aMethodsCoder asElement margin: (BlInsets all: 5) ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newExamplesDropdownButtonForViewModel: anExampleViewModel
				  methodsCoder: aMethodsCoder ];
		  actionStencil: [ 
			  GtPharoCoderUIUtility
				  newTestSuiteDropdownForViewModel: aTestSuiteViewModel
				  methodsCoder: aMethodsCoder ]
]

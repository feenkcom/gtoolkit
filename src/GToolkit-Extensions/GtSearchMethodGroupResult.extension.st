Extension { #name : #GtSearchMethodGroupResult }

{ #category : #'*GToolkit-Extensions' }
GtSearchMethodGroupResult >> gtItemsFor: aView [

	<gtView>
	| aMethodsCoder aTestSuiteViewModel |
	aMethodsCoder := self asCoder.
	aTestSuiteViewModel := GtPharoTestSuiteViewModel new 
		                       methodsCoderModel: aMethodsCoder.

	^ aView explicit
		  title: 'Live' translated;
		  priority: 10;
		  stencil: [ aMethodsCoder asElement margin: (BlInsets all: 5) ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility newExamplesButtonForMethodsCoder:
					  aMethodsCoder ];
		  actionStencil: [ 
			  GtPharoCoderUIUtility
				  newTestSuiteDropdownForViewModel: aTestSuiteViewModel
				  methodsCoder: aMethodsCoder ]
]

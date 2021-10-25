Extension { #name : #GtSearchMethodGroupResult }

{ #category : #'*GToolkit-Extensions' }
GtSearchMethodGroupResult >> gtItemsFor: aView [

	<gtView>
	| aMethodsCoder |
	aMethodsCoder := self asCoder.

	^ aView explicit
		  title: 'Live' translated;
		  priority: 10;
		  stencil: [ aMethodsCoder asElement margin: (BlInsets all: 5) ];
		  actionStencil: [ :aBrTab |
			  GtPharoCoderUIUtility newExamplesButtonForMethodsCoder: aMethodsCoder ];
		  actionStencil: [ :aBrTab |
			  GtPharoCoderUIUtility newTestSuiteButtonForMethodsCoder: aMethodsCoder ]
]

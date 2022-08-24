Extension { #name : #GtRlGToolkitExamplesExplorer }

{ #category : #'*GToolkit-Extensions' }
GtRlGToolkitExamplesExplorer >> gtViewAllExamplesInImageFor: aView context: aPhlowContext [
	<gtView>
	| anExampleViewModel |
	anExampleViewModel := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtExamplesForContext
			inPhlowContext: aPhlowContext.

	^ aView explicit
		title: 'All Smalltalk Examples';
		priority: 20;
		stencil: [ | aCollection aGroup aGroupView anElement |
			aCollection := Smalltalk gtExamplesContained
					collect: [ :eachExample | eachExample asCachedExampleWithResult ].
			aGroup := GtExampleGroup withAll: aCollection.
			aGroupView := GtPhlowView empty on: aGroup perform: #gtExamplesFor:.
			anElement := aGroupView asElement.
			anElement userData at: #gtExamplesFor: put: aGroup.
			anExampleViewModel pharoExampleSuite stream: aCollection asAsyncStream.
			anElement ];
		actionStencil: [ :aBrTab | GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionUpdateButtonTooltip: 'Update example list'
]

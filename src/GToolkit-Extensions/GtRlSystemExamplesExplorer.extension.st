Extension { #name : #GtRlSystemExamplesExplorer }

{ #category : #'*GToolkit-Extensions' }
GtRlSystemExamplesExplorer >> gtViewAllExamplesFor: aView context: aPhlowContext [
	<gtView>
	| anExampleViewModel |
	anExampleViewModel := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtExamplesForContext
			inPhlowContext: aPhlowContext.

	^ aView explicit
		title: 'All gtoolkit examples';
		priority: 15;
		stencil: [ | aCollection aGroup aGroupView anElement |
			aGroup := self allContainedExamples.
			aCollection := aGroup examples.
			aGroupView := GtPhlowView empty on: aGroup perform: #gtExamplesFor:.
			anElement := aGroupView asElement.
			anElement userData at: #gtExamplesFor: put: aGroup.
			anExampleViewModel pharoExampleSuite stream: aCollection asAsyncStream.
			anElement ];
		actionStencil: [ :aBrTab | GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionUpdateButtonTooltip: 'Update example list'
]

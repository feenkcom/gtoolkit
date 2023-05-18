Extension { #name : #AssertionFailure }

{ #category : #'*GToolkit-Extensions' }
AssertionFailure >> gtTwoPanesStringDiffFor: aView [
	<gtView>
	| assertionContext anActual anExpected |
	self gtHasStack ifFalse: [ ^ aView empty ].
	
	assertionContext := self signalerContext findContextSuchThat: [ :ctx | 
		   (ctx hasTemporaryVariableNamed: #actual) and: [ 
			   ctx hasTemporaryVariableNamed: #expected ] ].
	assertionContext ifNil: [ ^ aView empty ].
	
	anActual := assertionContext readVariableNamed: #actual.
	anExpected := assertionContext readVariableNamed: #expected.
	anActual isString ifFalse: [ ^ aView empty ].
	anExpected isString ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Diff (two panes)';
		priority: 0;
		stencil: [
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Actual:';
				toLabelText: 'Expected:';
				change: (GtDiffBuilder
						computeDifferencesFrom: (anActual asString)
						to: (anExpected asString)
						using: GtCharacterGroupDiffSplitter words) ]
]

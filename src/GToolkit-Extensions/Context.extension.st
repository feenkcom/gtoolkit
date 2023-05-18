Extension { #name : #Context }

{ #category : #'*GToolkit-Extensions' }
Context >> gtTwoPanesStringDiffFor: aView [
	<gtView>
	| anActual anExpected |
	(self hasTemporaryVariableNamed: #actual) ifFalse: [ ^ aView empty ].
	(self hasTemporaryVariableNamed: #expected) ifFalse: [ ^ aView empty ].

	anActual := self readVariableNamed: #actual.
	anExpected := self readVariableNamed: #expected.
	anActual isString ifFalse: [ ^ aView empty ].
	anExpected isString ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Diff (two panes)';
		priority: 8;
		stencil: [ GtDiffElementWithLabelStencil new
				fromLabelText: 'Actual:';
				toLabelText: 'Expected:';
				change: (GtDiffBuilder
						computeDifferencesFrom: anActual asString
						to: anExpected asString
						using: GtCharacterGroupDiffSplitter words) ]
]

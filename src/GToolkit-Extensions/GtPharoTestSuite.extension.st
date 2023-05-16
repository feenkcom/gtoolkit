Extension { #name : #GtPharoTestSuite }

{ #category : #'*GToolkit-Extensions' }
GtPharoTestSuite >> gtLiveFor: aView [
	<gtView>
	testCasesStream ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Test cases';
		priority: 1;
		items: [ self allTestCases ];
		column: 'Number'
			text: [ :_ :anIndex | anIndex ]
			width: 50;
		column: 'Name' text: #compiledMethod;
		column: 'State'
			stencil: [ :aTest | 
				BrHorizontalPane new
					fitContent;
					alignCenter;
					addChild: (BrFrame new
							exact: 8 @ 8;
							background: aTest state color);
					addChild: (BrLabel new
							fitContent;
							aptitude: BrGlamorousLabelAptitude;
							margin: (BlInsets left: 5);
							text: aTest stateLabel) ];
		actionUpdateButton
]

Extension { #name : #Behavior }

{ #category : #'*GToolkit-Extensions' }
Behavior >> exampleViewModelWith: aMethodsCoder fromContext: aPhlowContext [
	<return: #GtPharoExampleSuiteViewModel>
	^ aPhlowContext
		optionAt: #exampleViewModel
		ifPresent: [ :anExampleViewModel | anExampleViewModel ]
		ifAbsentPut: [ | aSuiteModel aViewModel aHandler |
			aSuiteModel := GtPharoExampleSuite new.
			aViewModel := GtPharoExampleSuiteViewModel new pharoExampleSuite: aSuiteModel.

			aHandler := GtPharoExampleSuiteMethodsCoderMediator
					forMethodsCoder: aMethodsCoder
					suiteModel: aSuiteModel
					viewModel: aViewModel.
			aPhlowContext optionAt: #exampleViewModelHandler put: aHandler.

			aViewModel ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderStreamingMethodsFor: aView context: aPhlowContext [
	<gtClassView>
	| aMethodsCoder aMethodsCoderViewModel aTestSuiteViewModel anExampleViewModel aNewMethodCoderHolder view |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: self.
	aMethodsCoderViewModel := GtPharoStreamingMethodsCoderViewModel new
			streamingCodersModel: aMethodsCoder.
	aMethodsCoderViewModel
		shouldExpandByDefault: false;
		shouldHaveHeaderByDefault: false;
		selfObject: (aPhlowContext
				optionAt: #behaviorCoder
				ifPresent: [ :aBehaviorCoderUIModel | 
					aBehaviorCoderUIModel coderModel object ]
				ifAbsent: [ nil ]).

	aTestSuiteViewModel := self
			testSuiteViewModelWith: aMethodsCoder
			fromContext: aPhlowContext.

	anExampleViewModel := self
			exampleViewModelWith: aMethodsCoder
			fromContext: aPhlowContext.

	aNewMethodCoderHolder := ValueHolder new.

	view := aView explicit
			priority: 9;
			title: 'Methods';
			disableAsync;
			actionDropdownButtonIcon: BrGlamorousVectorIcons filter
				tooltip: 'Filter'
				content: [ :element | aMethodsCoder filterDropDown: element ];
			actionDropdownButtonDo: [ :aDrodownAction | 
				aDrodownAction dropdown
					icon: BrGlamorousVectorIcons add;
					tooltip: 'Add new method';
					content: [ :aButton | 
						| aNewMethodCoder aNewMethodCoderViewModel aHandler |
						aNewMethodCoderHolder contents
							ifNotNil: [ :aContents | aNewMethodCoderViewModel := aContents ]
							ifNil: [ aNewMethodCoder := GtPharoMethodCoder forNewMethod: self.
								aNewMethodCoder
									currentSourceString: 'newMethod' , String cr , String tab , '"This is a new method"'.

								aNewMethodCoderViewModel := aNewMethodCoder asCoderViewModel.
								aNewMethodCoderViewModel
									withoutHeader;
									expanded: true;
									focused: true;
									moveCursorAtEnd.

								aNewMethodCoderHolder contents: aNewMethodCoderViewModel.

								aHandler := GtPharoNewMethodCodeSavedHandler new
										methodsCoderViewModel: aMethodsCoderViewModel;
										element: aButton;
										methodCoderHolder: aNewMethodCoderHolder.

								aNewMethodCoderViewModel weak
									when: GtMethodCoderSaved
									send: #onAnnouncement:
									to: aHandler ].

						(GtExpandedOnlyCoderElement new coderViewModel: aNewMethodCoderViewModel)
							hExact: 300;
							vFitContent;
							background: Color white;
							padding: (BlInsets all: 5);
							addAptitude: BrGlamorousFocusableShadowAptitude new ];
					name: GtPharoBehaviorCoder addNewMethodButtonName ].

	(aMethodsCoder codeGeneratorsAvailableFor: aMethodsCoderViewModel)
		ifTrue: [ 
			view
				actionDropdownButtonIcon: BrGlamorousVectorIcons robot
				tooltip: 'Generate'
				content: [ :anElement | 
					aMethodsCoder codeGeneratorsDropDown: anElement for: aMethodsCoderViewModel ] ].
	^ view
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :aButton | 
					aButton phlow spawnObject: aMethodsCoderViewModel ] ];
		actionStencil: [ :aBrTab | 
			GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionStencil: [ :aBrTab | 
			GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ];
		stencil: [ GtPharoStreamingMethodsCoderElement new
			streamingCodersViewModel: aMethodsCoderViewModel ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> testSuiteViewModelWith: aMethodsCoder fromContext: aPhlowContext [
	<return: #GtPharoTestSuiteViewModel>
	^ aPhlowContext
		optionAt: #testSuiteViewModel
		ifPresent: [ :aTestSuiteViewModel | aTestSuiteViewModel ]
		ifAbsentPut: [ | aSuiteModel aViewModel aHandler |
			aSuiteModel := GtPharoTestSuite forStream: aMethodsCoder itemsStream.
			aViewModel := GtPharoTestSuiteViewModel new pharoTestSuite: aSuiteModel.

			aHandler := GtPharoTestSuiteMethodsCoderMediator
					forMethodsCoder: aMethodsCoder
					suiteModel: aSuiteModel
					viewModel: aViewModel.
			aPhlowContext optionAt: #testSuiteViewModelHandler put: aHandler.

			aViewModel ]
]

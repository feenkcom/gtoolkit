Extension { #name : #Behavior }

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
				ifPresent: [ :aBehaviorCoderUIModel | aBehaviorCoderUIModel coderModel object ]
				ifAbsent: [ nil ]).

	aTestSuiteViewModel := self
			testSuiteViewModelWith: aMethodsCoder
			fromContext: aPhlowContext.

	anExampleViewModel := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtCoderStreamingMethodsForContext
			inPhlowContext: aPhlowContext
			forMethodsCoder: aMethodsCoder.

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
							addAptitude: BrGlamorousFocusableShadowAptitude new;
							when: GtPhlowObjectToSpawn
								do: [ :aSpawnEvent | 
									aSpawnEvent consumed: true.
									aButton
										fireEvent: (GtPhlowObjectToSpawn new
												previousSpawnEvent: aSpawnEvent;
												tool: aSpawnEvent tool;
												sourceElement: aSpawnEvent currentTarget;
												spawnDestination: aSpawnEvent spawnDestination;
												in: [ :anNewEvent | anNewEvent propertyAt: #spawnContainer put: aSpawnEvent currentTarget ];
												yourself) ] ];
					name: GtPharoBehaviorCoder addNewMethodButtonName ].

	(aMethodsCoder codeGeneratorsAvailableFor: aMethodsCoderViewModel)
		ifTrue: [ view
				actionDropdownButtonIcon: BrGlamorousVectorIcons robot
				tooltip: 'Generate'
				content: [ :anElement | aMethodsCoder codeGeneratorsDropDown: anElement for: aMethodsCoderViewModel ] ].
	^ view
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :aButton | aButton phlow spawnObject: aMethodsCoderViewModel ] ];
		actionStencil: [ :aBrTab | GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionStencil: [ :aBrTab | GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ];
		stencil: [ GtPharoStreamingMethodsCoderElement new
				streamingCodersViewModel: aMethodsCoderViewModel ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					object: self;
					tooltip: 'Search Code';
					actOn: [ :anActOnEvent :anItem :theButton | 
						| acted |
						acted := false.
						(anItem isKindOf: RPackage)
							ifTrue: [ self navigationModel selectPackage: anItem.
								acted := true ].
						(anItem isKindOf: ClassDescription)
							ifTrue: [ self navigationModel selectClass: anItem.
								acted := true ].
						(anItem isKindOf: CompiledMethod)
							ifTrue: [ self navigationModel selectMethod: anItem.
								acted := true ].
						acted ifTrue: [ anActOnEvent beActed ] ];
					asElement ]
			tooltip: 'Search Code'
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

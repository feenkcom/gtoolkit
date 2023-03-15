Extension { #name : #Behavior }

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderStreamingMethodsFor: aView context: aPhlowContext [
	<gtClassView>
	| aMethodsCoder aMethodsCoderViewModel aTestSuiteViewModel anExampleViewModel view |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: self.
	aMethodsCoderViewModel := GtPharoStreamingMethodsCoderViewModel new
			streamingCodersModel: aMethodsCoder;
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


	view := aView explicit
			priority: 9;
			title: 'Methods';
			disableAsync;
			actionDropdownButtonIcon: BrGlamorousVectorIcons filter
				tooltip: 'Filter'
				content: [ :element | aMethodsCoder filterDropDown: element ];
			actionDropdownButtonDo: [ :aDrodownAction | self gtNewMethodDropdown: aDrodownAction withModel: aMethodsCoderViewModel ].

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
					id: GtPharoSearchCodeButtonId;
					actOn: [ :anActOnEvent :anItem :theButton | 
						| acted navigationModel |
						acted := false.
						navigationModel := theButton phlow firstParentWithView phlow
								firstParentWithView navigationModel.
						(anItem isKindOf: RPackage)
							ifTrue: [ navigationModel selectPackage: anItem.
								acted := true ].
						(anItem isKindOf: ClassDescription)
							ifTrue: [ navigationModel selectClass: anItem.
								acted := true ].
						(anItem isKindOf: CompiledMethod)
							ifTrue: [ navigationModel selectMethod: anItem.
								acted := true ].
						acted ifTrue: [ anActOnEvent beActed ] ];
					asElement ]
			tooltip: 'Search Code'
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtNewMethodDropdown: aDrodownAction withModel: aMethodsCoderViewModel [
	^ aDrodownAction dropdown
		name: GtPharoBehaviorCoder addNewMethodButtonName;
		icon: BrGlamorousVectorIcons add;
		tooltip: 'Add new method';
		content: [ :aButton | 
			| aNewMethodCoder aNewMethodCoderViewModel aHandler aNewMethodCoderHolder |
			aNewMethodCoder := (GtPharoMethodCoder forNewMethod: self)
					currentSourceString: 'newMethod' , String cr , String tab , '"This is a new method"';
					protocol: #accessing;
					yourself.

			aNewMethodCoderViewModel := aNewMethodCoder asCoderViewModel
					withoutHeader;
					expanded: true;
					focused: true;
					moveCursorAtEnd.

			aNewMethodCoderHolder := ValueHolder new contents: aNewMethodCoderViewModel.

			aHandler := GtPharoNewMethodCodeSavedHandler new
					methodsCoderViewModel: aMethodsCoderViewModel;
					element: aButton;
					methodCoderHolder: aNewMethodCoderHolder.

			aNewMethodCoderViewModel weak
				when: GtMethodCoderSaved
				send: #onAnnouncement:
				to: aHandler.

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
									yourself) ] ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> testSuiteViewModelWith: aMethodsCoder fromContext: aPhlowContext [
	<return: #GtPharoTestSuiteViewModel>
	^ aPhlowContext
		optionAt: #testSuiteViewModel
		ifPresent: [ :aTestSuiteViewModel | 
			aMethodsCoder testSuite: aTestSuiteViewModel pharoTestSuite.
			aTestSuiteViewModel ]
		ifAbsentPut: [ | aSuiteModel aViewModel aHandler |
			aSuiteModel := GtPharoTestSuite forStream: aMethodsCoder itemsStream.
			aViewModel := GtPharoTestSuiteViewModel new pharoTestSuite: aSuiteModel.
			aMethodsCoder testSuite: aViewModel pharoTestSuite.

			aHandler := GtPharoTestSuiteMethodsCoderMediator
					forMethodsCoder: aMethodsCoder
					suiteModel: aSuiteModel
					viewModel: aViewModel.
			aPhlowContext optionAt: #testSuiteViewModelHandler put: aHandler.

			aViewModel ]
]

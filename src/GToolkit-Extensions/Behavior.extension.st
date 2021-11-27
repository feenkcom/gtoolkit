Extension { #name : #Behavior }

{ #category : #'*GToolkit-Extensions' }
Behavior >> exampleViewModelWith: aMethodsCoder fromContext: aPhlowContext [
	<return: #GtPharoExampleSuiteViewModel>

	^ aPhlowContext
		  optionAt: #exampleViewModel
		  ifPresent: [ :anExampleViewModel | anExampleViewModel ]
		  ifAbsentPut: [
				| aSuiteModel |
				aSuiteModel := GtPharoExampleSuite forStream: aMethodsCoder itemsStream.
		  		GtPharoExampleSuiteViewModel new
					pharoExampleSuite: aSuiteModel;
					when: GtPharoSuiteSelectedStateChanged do: [ :anEvent |
						aMethodsCoder additionalFilters: (GtPharoExampleStateFilter new
					 		resultState: anEvent state;
					 		pharoExampleSuite: aSuiteModel) ];
					yourself ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderStreamingMethodsFor: aView context: aPhlowContext [
	<gtClassView>
	| aMethodsCoder aMethodsCoderUIModel aTestSuiteViewModel anExampleViewModel |

	aMethodsCoderUIModel := (GtPharoStreamingBehaviorMethodsCoder forBehavior: self) asCoderUIModel.
	aMethodsCoder := aMethodsCoderUIModel codersModel.

	aTestSuiteViewModel := self
		testSuiteViewModelWith: aMethodsCoder
		fromContext: aPhlowContext.
		
	anExampleViewModel := self
		exampleViewModelWith: aMethodsCoder
		fromContext: aPhlowContext.

	^ aView explicit
		priority: 10.5;
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
					| aNewMethodCoder aNewMethodCoderViewModel |

					aNewMethodCoder := GtPharoMethodCoder forNewMethod: self.
					aNewMethodCoder
						currentSourceString: 'newMethod', String cr, String tab, '"This is a new method"';
						withoutHeader.

					aNewMethodCoderViewModel := aNewMethodCoder asCoderViewModel.
					aNewMethodCoderViewModel
						expanded: true;
						focused: true;
						moveCursorAtEnd.

					aNewMethodCoderViewModel
						when: GtMethodCoderSaved
						do: [ :aSavedEvent |
							aMethodsCoderUIModel
								expandAndFocusCompiledMethod: aSavedEvent method;
								scrollToCompiledMethod: aSavedEvent method.
							aButton fireEvent: BrDropdownHideWish new ].

					(GtExpandedOnlyCoderElement new coderUIModel: aNewMethodCoderViewModel)
						hExact: 300;
						vFitContent;
						background: Color white;
						padding: (BlInsets all: 5);
						addAptitude: BrGlamorousFocusableShadowAptitude new ];
				name: GtPharoBehaviorCoder addNewMethodButtonName ];
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :aButton | aButton phlow spawnObject: aMethodsCoderUIModel ] ];
		actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newTestsDropdownButtonForViewModel: aTestSuiteViewModel ];
		stencil: [ GtPharoFilteredStreamingMethodsCoderElement new pharoFilteredStreamingMethodsCoderViewModel: aMethodsCoderUIModel ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> testSuiteViewModelWith: aMethodsCoder fromContext: aPhlowContext [
	<return: #GtPharoTestSuiteViewModel>

	^ aPhlowContext
		  optionAt: #testSuiteViewModel
		  ifPresent: [ :aTestSuiteViewModel | aTestSuiteViewModel ]
		  ifAbsentPut: [ 
				| aSuiteModel |
				aSuiteModel := GtPharoTestSuite forStream: aMethodsCoder itemsStream.
		  		GtPharoTestSuiteViewModel new
					pharoTestSuite: aSuiteModel;
					when: GtPharoSuiteSelectedStateChanged do: [ :anEvent |
						aMethodsCoder additionalFilters: (GtPharoTestCaseStateFilter new
					 		resultState: anEvent state;
					 		pharoTestSuite: aSuiteModel) ];
					yourself ]
]

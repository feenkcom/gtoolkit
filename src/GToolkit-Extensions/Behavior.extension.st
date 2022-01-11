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
	| aMethodsCoder aMethodsCoderViewModel aTestSuiteViewModel anExampleViewModel aNewMethodCoderHolder |
	
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: self.
	aMethodsCoderViewModel := GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: aMethodsCoder.
	aMethodsCoderViewModel
		shouldExpandByDefault: false;
		shouldHaveHeaderByDefault: false;
		selfObject: (aPhlowContext optionAt: #behaviorCoder
			ifPresent: [ :aBehaviorCoderUIModel | aBehaviorCoderUIModel coderModel object ]
			ifAbsent: [ nil ]).

	aTestSuiteViewModel := self
		testSuiteViewModelWith: aMethodsCoder
		fromContext: aPhlowContext.
		
	anExampleViewModel := self
		exampleViewModelWith: aMethodsCoder
		fromContext: aPhlowContext.
		
	aNewMethodCoderHolder := ValueHolder new.

	^ aView explicit
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
					| aNewMethodCoder aNewMethodCoderViewModel |

					aNewMethodCoderHolder contents
						ifNotNil: [ :aContents |
							aNewMethodCoderViewModel := aContents ]
						ifNil: [
					
						aNewMethodCoder := GtPharoMethodCoder forNewMethod: self.
						aNewMethodCoder
							currentSourceString: 'newMethod', String cr, String tab, '"This is a new method"'.

						aNewMethodCoderViewModel := aNewMethodCoder asCoderUIModel.
						aNewMethodCoderViewModel
							withoutHeader;
							expanded: true;
							focused: true;
							moveCursorAtEnd.
						
						aNewMethodCoderHolder contents: aNewMethodCoderViewModel.

						aNewMethodCoderViewModel
							when: GtMethodCoderSaved
							do: [ :aSavedEvent |
								aMethodsCoderViewModel
									expandAndFocusCompiledMethod: aSavedEvent method;
									scrollToCompiledMethod: aSavedEvent method.
								aButton fireEvent: BrDropdownHideWish new .
								aNewMethodCoderHolder contents: nil ] ].

						(GtExpandedOnlyCoderElement new coderUIModel: aNewMethodCoderViewModel)
							hExact: 300;
							vFitContent;
							background: Color white;
							padding: (BlInsets all: 5);
							addAptitude: BrGlamorousFocusableShadowAptitude new ];
				name: GtPharoBehaviorCoder addNewMethodButtonName ];
		actionDropdownButtonIcon: BrGlamorousVectorIcons robot
		  tooltip: 'Generate'
		  content: [ :anElement | 
			  aMethodsCoder
				  codeGeneratorsDropDown: anElement
				  for: aMethodsCoderViewModel ];
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :aButton | aButton phlow spawnObject: aMethodsCoderViewModel ] ];
		actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newTestsDropdownButtonForViewModel: aTestSuiteViewModel ];
		stencil: [ GtPharoStreamingMethodsCoderElement new streamingCodersViewModel: aMethodsCoderViewModel ]
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

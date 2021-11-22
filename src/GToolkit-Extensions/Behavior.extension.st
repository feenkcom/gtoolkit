Extension { #name : #Behavior }

{ #category : #'*GToolkit-Extensions' }
Behavior >> exampleViewModelWith: aMethodsCoder fromContext: aPhlowContext [

	<return: #GtPharoExampleSuiteViewModel>
	^ aPhlowContext
		  optionAt: #exampleViewModel
		  ifPresent: [ :anExampleViewModel | anExampleViewModel ]
		  ifAbsentPut: [ 
		  	GtPharoExampleSuiteViewModel new methodsCoderModel: aMethodsCoder ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderMethodsFor: aView context: aPhlowContext [

	<gtClassView>
	| aMethodsCoderUIModel aMethodsCoder aTestSuiteViewModel anExampleViewModel |
	aMethodsCoderUIModel := self methodsCoderFromContext: aPhlowContext.
	aMethodsCoder := aMethodsCoderUIModel coder.
	aTestSuiteViewModel := self
		                       testSuiteViewModelWith: aMethodsCoder
		                       fromContext: aPhlowContext.

	anExampleViewModel := self
		                      exampleViewModelWith: aMethodsCoder
		                      fromContext: aPhlowContext.

	^ aView explicit
		  priority: 10;
		  title: 'Methods';
		  disableAsync;
		  actionDropdownButtonIcon: BrGlamorousVectorIcons filter
		  tooltip: 'Filter'
		  content: [ :element | aMethodsCoder filterDropDown: element ];
		  actionButtonDo: [ :aButtonAction | 
			  aButtonAction
				  icon: BrGlamorousVectorIcons add;
				  tooltip: 'Add new method';
				  action: [ aMethodsCoderUIModel addNewCoder ];
				  name: GtPharoBehaviorCoder addNewMethodButtonName ];
		  actionDropdownButtonIcon: BrGlamorousVectorIcons robot
		  tooltip: 'Generate'
		  content: [ :element | 
			  aMethodsCoder
				  codeGeneratorsDropDown: element
				  for: aMethodsCoderUIModel ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newExamplesDropdownButtonForViewModel: anExampleViewModel
				  methodsCoder: aMethodsCoder ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newTestSuiteDropdownForViewModel: aTestSuiteViewModel
				  methodsCoder: aMethodsCoder ];
		  stencil: [ aMethodsCoderUIModel asElement ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderStreamingMethodsFor: aView context: aPhlowContext [
	"<gtClassView>"
	| aMethodsCoderUIModel aMethodsCoder |

	aMethodsCoderUIModel := (GtPharoStreamingBehaviorMethodsCoder forBehavior: self) asCoderUIModel.
	aMethodsCoder := aMethodsCoderUIModel codersModel.

	^ aView explicit
		priority: 10.5;
		title: 'Streaming Methods';
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
							aMethodsCoderUIModel expandAndFocusCompiledMethod: aSavedEvent method.
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
		stencil: [ GtPharoFilteredStreamingMethodsCoderElement new pharoFilteredStreamingMethodsCoderViewModel: aMethodsCoderUIModel ]
]

{ #category : #'*GToolkit-Extensions' }
Behavior >> testSuiteViewModelWith: aMethodsCoder fromContext: aPhlowContext [

	<return: #GtPharoTestSuiteViewModel>
	^ aPhlowContext
		  optionAt: #testSuiteViewModel
		  ifPresent: [ :aTestSuiteViewModel | aTestSuiteViewModel ]
		  ifAbsentPut: [ 
		  	GtPharoTestSuiteViewModel new methodsCoderModel: aMethodsCoder ]
]

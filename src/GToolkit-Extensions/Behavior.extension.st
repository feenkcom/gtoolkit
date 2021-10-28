Extension { #name : #Behavior }

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderMethodsFor: aView context: aPhlowContext [

	<gtClassView>
	| aMethodsCoderUIModel aMethodsCoder aTestSuiteViewModel |
	aMethodsCoderUIModel := self methodsCoderFromContext: aPhlowContext.
	aMethodsCoder := aMethodsCoderUIModel coder.
	aTestSuiteViewModel := self
		                       testSuiteViewModelWith: aMethodsCoder
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
			  GtPharoCoderUIUtility newExamplesButtonForMethodsCoder:
				  aMethodsCoder ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				  newTestSuiteDropdownForViewModel: aTestSuiteViewModel
				  methodsCoder: aMethodsCoder ];
		  stencil: [ aMethodsCoderUIModel asElement ]
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

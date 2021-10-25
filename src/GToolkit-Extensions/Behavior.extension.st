Extension { #name : #Behavior }

{ #category : #'*GToolkit-Extensions' }
Behavior >> gtCoderMethodsFor: aView context: aPhlowContext [

	<gtClassView>
	| aMethodsCoderUIModel aMethodsCoder |
	aMethodsCoderUIModel := self methodsCoderFromContext: aPhlowContext.
	aMethodsCoder := aMethodsCoderUIModel coder.

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
			  GtPharoCoderUIUtility newExamplesButtonForMethodsCoder: aMethodsCoder ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility newTestSuiteButtonForMethodsCoder: aMethodsCoder ];
		  stencil: [ aMethodsCoderUIModel asElement ]
]

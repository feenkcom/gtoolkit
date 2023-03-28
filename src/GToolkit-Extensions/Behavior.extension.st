Extension { #name : #Behavior }

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

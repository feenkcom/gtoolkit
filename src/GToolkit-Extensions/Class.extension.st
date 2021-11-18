Extension { #name : #Class }

{ #category : #'*GToolkit-Extensions' }
Class >> gtAllConfigurationReferencesFor: aView [
	<gtView>
	<gtClassView>

	(self name beginsWith: ConfigurationOf name) ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'References';
		tooltip: 'Class and configuration references';
		priority: 40;
		stencil: [ 
			| aName |
			aName := self name withoutPrefix: ConfigurationOf name.
			self gtReferences
			| (('`@receiver configuration: ''', aName, ''' with: `@arg') gtASTMatches) ]
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtAllReferencesFor: aView [
	<gtView>
	<gtClassView>
	
	(self name beginsWith: ConfigurationOf name) ifTrue: [ ^ aView empty ].
	
	^ aView forward
		title: 'References';
		tooltip: 'Class references';
		priority: 40;
		object: [ self gtReferences ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtExamplesMapFor: aView context: aPhlowContext [

	<gtView>
	<gtClassView>
	| aMethodsCoderUIModel aMethodsCoder |
	aMethodsCoderUIModel := self methodsCoderFromContext: aPhlowContext.
	aMethodsCoder := aMethodsCoderUIModel coder.
	aMethodsCoder exampler hasExamples ifFalse: [ ^ aView empty ].
	^ aView forward
		  title: 'Examples map';
		  priority: 11;
		  object: [ 
			  | allExamples |
			  allExamples := Array streamContents: [ :aStream | 
					                 aMethodsCoder exampler 
						                 allExecutableExampleCodersDo: [ 
							                 :aCoder 
							                 :anExample | aStream nextPut: anExample ] ].
			  GtExampleGroup withAll: allExamples ];
		  view: #gtMapFor:;
		  actionStencilDo: [ :anExplicitAction | 
			  anExplicitAction
				  priority: 80;
				  stencil: [ :aBrTab | 
					  GtPharoCoderUIUtility newExamplesButtonForMethodsCoder:
							  aMethodsCoder ] ];
		  updateWhen:
			  GtCodersCoderAdded , GtCodersCoderRemoved , GtCodersCodersChanged
			  , GtCoderSourceCodeChanged
		  in: [ aMethodsCoder ];
		  addAutoUpdate: GtPhlowUpdateViewOnAddedToScene
]

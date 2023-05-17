Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtAllReferencesFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit
		title: 'References';
		tooltip: 'Class and baseline references';
		priority: 40;
		stencil: [ 
			| aName |
			aName := self name withoutPrefix: BaselineOf name.
			self gtReferences
			| (('`@receiver baseline: ''', aName, ''' with: `@arg') gtASTMatches) ]
]

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtDependencyAnalyzerFor: aView [
	<gtClassView>
	
	| anAnalyzer |
	^ aView explicit
		title: 'Dependency Analysis';
		priority: 41;
		stencil: [ 
			| anObjectHolder |
			anAnalyzer := GtDependencyAnalyzerEasy analyzeBaseline: self.
			anObjectHolder := GtInspectorObject new object: anAnalyzer; viewSelector: #gtDirectlyDefinedPackagesFor:context:.
			GtInspector new objectHolder: anObjectHolder ];
		actionButtonIcon: BrGlamorousVectorIcons refresh 
			tooltip: 'Update dependency analysis' 
			action: [ :aButton :aTab | 
				aButton disable.
				[ aTab viewContentElement phlow syncUpdate ] asAsyncPromise 
					then: [ :aResult | aButton enable ] 
					otherwise: [ :anError | aButton enable ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect dependency analyzer' 
			action: [ :aButton | anAnalyzer ifNotNil: [ 
				aButton phlow spawnObject: anAnalyzer ] ]
]

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtViewAllExamplesFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'All examples';
		priority: 33;
		tooltip: 'Examples defined in packages contained in the baseline or in dependencies.';
		object: [
			GtRlSystemExamplesExplorer forProject: (self gtRlProjectWithRepository: '') ];
		view: #gtViewAllExamplesFor:context:
]

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtViewLocalExamplesFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Local examples';
		priority: 30;
		tooltip: 'Examples defined in packages directly contained within the baseline.';
		object: [
			GtRlProjectExamplesExplorer forProject: (self gtRlProjectWithRepository: '') ];
		view: #gtViewExamplesFor:
]

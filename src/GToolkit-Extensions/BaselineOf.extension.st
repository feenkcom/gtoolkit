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
	
	^ aView explicit
		title: 'Dependency Analysis';
		priority: 41;
		stencil: [ 
			| anAnalyzer anObjectHolder |
			anAnalyzer := GtDependencyAnalyzerEasy analyzeBaseline: self.
			anObjectHolder := GtInspectorObject new object: anAnalyzer; viewSelector: #gtDirectlyDefinedPackagesFor:.
			GtInspector new objectHolder: anObjectHolder ];
		actionUpdateButtonTooltip: 'Update dependency analysis';
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect dependency analyzer' 
			action: [ :aButton | aButton phlow spawnObject: (GtDependencyAnalyzerEasy analyzeBaseline: self) ]
]

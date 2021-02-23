Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-Extensions' }
BaselineOf class >> gtDependencyAnalyzerFor: aView [
	<gtClassView>
	
	^ aView explicit
		title: 'Dependency Analysis';
		priority: 40;
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

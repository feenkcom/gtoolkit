Extension { #name : #RPackage }

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtDependencyAnalyzerFor: aView [
	<gtPackageView>
	
	^ aView explicit
		title: 'Dependency Analysis';
		priority: 40;
		stencil: [ 
			| anAnalyzer anObjectHolder |
			anAnalyzer := GtDependencyAnalyzerEasy analyzePackageNamed: self name.
			anObjectHolder := GtInspectorObject new object: anAnalyzer; viewSelector: #gtPackageDependenciesFor:.
			GtInspector new objectHolder: anObjectHolder ];
		actionUpdateButtonTooltip: 'Update dependency analysis';
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect dependency analyzer' 
			action: [ :aButton | aButton phlow spawnObject: (GtDependencyAnalyzerEasy analyzePackageNamed: self name) ]
]

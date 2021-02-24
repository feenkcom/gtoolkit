Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-DependencyAnalyzer' }
BaselineOf class >> gtDependencyAnalysisPreloadedBaselines [
	"Return collection of preloaded baselines. It is used by ${class:GtDependencyAnalyzerForBaseline}$, see ${method:GtDependencyAnalyzerEasy class>>#analyzeBaseline:}$"
	<return: #Collection>
	^ GtDependencyAnalyzerEasy preloadedBaselines
]

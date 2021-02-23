Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-DependencyAnalyzer' }
BaselineOf class >> gtDependencyAnalysisPreloadedBaselines [
	"Return collection of preloaded baselines. It is used by ${class:GtDependencyAnalyzerForBaseline}$, see ${method:"
	<return: #Collection>
	^ GtDependencyAnalyzerEasy preloadedBaselines
]

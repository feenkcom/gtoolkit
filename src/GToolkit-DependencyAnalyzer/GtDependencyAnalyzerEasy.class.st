"
I provide a simple API to analyze code.
"
Class {
	#name : #GtDependencyAnalyzerEasy,
	#superclass : #Object,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #baselines }
GtDependencyAnalyzerEasy class >> analyzeBaseline: aBaselineClass [

	^ GtDependencyAnalyzerForBaseline new
		baseline: aBaselineClass;
		preloadedBaselines: (aBaselineClass gtDependencyAnalysisPreloadedBaselines)
]

{ #category : #baselines }
GtDependencyAnalyzerEasy class >> analyzePackageNamed: aPackageNamed [
	| aPackage aBaselineCollection |
	aPackage := aPackageNamed asPackage.
	aBaselineCollection := GtDependencyAnalyzerForPackage baselinesForPackage: aPackage.
	
	^ aBaselineCollection 
		ifEmpty: [ GtDependencyAnalyzerForPackage packageNamed: aPackageNamed ] 
		ifNotEmpty: [ (GtDependencyAnalyzerForPackageFromBaseline
			package: aPackageNamed
			baseline: aBaselineCollection anyOne)
				preloadedBaselines: aBaselineCollection anyOne gtDependencyAnalysisPreloadedBaselines ]
]

{ #category : #baselines }
GtDependencyAnalyzerEasy class >> preloadedBaselines [
	^ { BaselineOfPharoBootstrap . 
		BaselineOfMorphic . 
		BaselineOfMetacello . 
		BaselineOfMonticello . 
		BaselineOfIceberg }
]

Class {
	#name : #GtBaselinesShouldProperlySpecifyDependencies,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #example }
GtBaselinesShouldProperlySpecifyDependencies class >> blocSpartaPackageAnalysisExample [
	<gtExample>
	| analyzer packageAnalyzers blocSpartaPackageAnaluser |
	analyzer :=GtDependencyAnalyzerEasy analyzeBaseline: BaselineOfBloc.

	packageAnalyzers := analyzer directlyDefinedPackagesWithContext: GtDependencyAnalyzerContext new.

	blocSpartaPackageAnaluser := packageAnalyzers detect: [ :aPackageAnalyser | aPackageAnalyser name = 'Bloc-Sparta' ].
	
	^ blocSpartaPackageAnaluser
]

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> issues [
	| gtProject allDependencies analyzers |
	gtProject := BaselineOfGToolkit gtRlProjectWithRepository: 'github://feenkcom/gtoolkit/src'.
	allDependencies := gtProject withAllChildProjects.

	analyzers := allDependencies collect: [:aProject |
		(GtDependencyAnalyzerForBaseline new baseline: aProject baselineClass)
			preloadedBaselines: aProject baselineClass gtDependencyAnalysisPreloadedBaselines ].

	^ analyzers select: [ :aBaselineAnalizer | 
		(aBaselineAnalizer issuesWithContext: GtDependencyAnalyzerContext new) size > 0 ]
	
]

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> name [
	^ 'Baselines should properly define project dependencies'
]

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> status [ 
	^ GtNeutralConstraintStatus new
]

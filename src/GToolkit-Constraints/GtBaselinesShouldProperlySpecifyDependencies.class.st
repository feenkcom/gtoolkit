Class {
	#name : #GtBaselinesShouldProperlySpecifyDependencies,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtBaselinesShouldProperlySpecifyDependencies >> issues [
	| gtProject allDependencies analyzers |
	gtProject := BaselineOfGToolkit gtRlProjectWithRepository: 'github://feenkcom/gtoolkit/src'.
	allDependencies := gtProject withAllChildProjects.

	analyzers := allDependencies collect: [:aProject |
		(GtDependencyAnalyzerForBaseline new baseline: aProject baselineClass)
			preloadedBaselines: { 
				BaselineOfPharoBootstrap . 
				BaselineOfMorphic . 
				BaselineOfMetacello . 
				BaselineOfMonticello }.].
	
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

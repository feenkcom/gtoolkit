Class {
	#name : #GtDependencyAnalyzerPackageNotAssignedToBaselineIssue,
	#superclass : #GtDependencyAnalyzerPackageIssue,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #printing }
GtDependencyAnalyzerPackageNotAssignedToBaselineIssue >> printOn: aStream [
	aStream
		nextPutAll: 'Package is not defined in any loaded baseline'
]

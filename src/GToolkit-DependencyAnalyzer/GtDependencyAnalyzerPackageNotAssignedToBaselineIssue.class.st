Class {
	#name : #GtDependencyAnalyzerPackageNotAssignedToBaselineIssue,
	#superclass : #GtDependencyAnalyzerPackageIssue,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #printing }
GtDependencyAnalyzerPackageNotAssignedToBaselineIssue >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Package is not defined in any loaded baseline'
]

{ #category : #printing }
GtDependencyAnalyzerPackageNotAssignedToBaselineIssue >> printOn: aStream [
	aStream
		nextPutAll: 'Package ';
		print: self package name;
		nextPutAll: ' is not defined in any loaded baseline'
]

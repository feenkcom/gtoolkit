Class {
	#name : #GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue,
	#superclass : #GtDependencyAnalyzerPackageFromBaselineIssue,
	#instVars : [
		'undefinedDependency'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #printing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> gtDisplayOn: aStream [
	aStream
		print: undefinedDependency name;
		nextPutAll: ' is undefined'
]

{ #category : #printing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> printOn: aStream [
	aStream
		nextPutAll: 'Package ';
		print: self package;
		nextPutAll: ' has undefined dependency to ';
		print: undefinedDependency name
]

{ #category : #accessing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> undefinedDependency [
	^ undefinedDependency
]

{ #category : #accessing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> undefinedDependency: anObject [
	undefinedDependency := anObject
]

Class {
	#name : #GtDependencyAnalyzerPackageDependencyStatus,
	#superclass : #Object,
	#instVars : [
		'package',
		'dependencyPackage',
		'dependencies'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> amountOfDependencies [
	^ dependencies size
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> dependencies [

	^ dependencies
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> dependencyPackage [

	^ dependencyPackage
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> dependencyPackage: anObject [

	dependencyPackage := anObject
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> dependencyPackageName [
	^ dependencyPackage name
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> package [

	^ package
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> package: anObject [

	package := anObject
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> statusColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyStatus >> statusLabel [
	^ self subclassResponsibility
]

Class {
	#name : #GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue,
	#superclass : #GtDependencyAnalyzerPackageFromBaselineIssue,
	#instVars : [
		'undefinedDependencies'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #'gt-extensions' }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> gtUndefinedDependenciesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Undefined dependencies';
		priority: 10;
		items: [ self undefinedDependencies sorted: [ :a :b | a name < b name ] ];
		itemText: [ :each | each name ]
]

{ #category : #printing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> printOn: aStream [
	aStream
		nextPutAll: 'Package has ';
		print: undefinedDependencies size;
		nextPutAll: ' undefined dependencies'
]

{ #category : #accessing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> undefinedDependencies [
	^ undefinedDependencies
]

{ #category : #accessing }
GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue >> undefinedDependencies: anObject [
	undefinedDependencies := anObject
]

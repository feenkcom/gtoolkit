Class {
	#name : #GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue,
	#superclass : #GtDependencyAnalyzerPackageIssue,
	#instVars : [
		'packagesInBaseline'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #printing }
GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Package is defined in more than one (';
		print: self packagesInBaseline size;
		nextPutAll: ') baseline'
]

{ #category : #'gt - extensions' }
GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue >> gtPackagesInBaselineFor: aView [

	<gtView>
	self packagesInBaseline ifNil: [ ^ aView empty ].

	^ aView list
		  title: 'Baselines';
		  priority: 1;
		  items: [ self packagesInBaseline ]
]

{ #category : #accessing }
GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue >> packagesInBaseline [
	^ packagesInBaseline
]

{ #category : #accessing }
GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue >> packagesInBaseline: anObject [
	packagesInBaseline := anObject
]

{ #category : #printing }
GtDependencyAnalyzerPackageIsDefinedInMultipleBaselinesIssue >> printOn: aStream [
	aStream
		nextPutAll: 'Package ';
		print: self package name;
		nextPutAll: ' is defined in more than one (';
		print: self packagesInBaseline size;
		nextPutAll: ') baseline'
]

Class {
	#name : #GtDependencyAnalyzerPackageIssue,
	#superclass : #Object,
	#instVars : [
		'package'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerPackageIssue >> package [
	^ package
]

{ #category : #accessing }
GtDependencyAnalyzerPackageIssue >> package: anObject [
	package := anObject
]

{ #category : #printing }
GtDependencyAnalyzerPackageIssue >> printOn: aStream [
	self subclassResponsibility
]

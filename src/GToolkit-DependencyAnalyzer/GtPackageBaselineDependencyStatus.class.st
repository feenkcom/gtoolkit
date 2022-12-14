Class {
	#name : #GtPackageBaselineDependencyStatus,
	#superclass : #Object,
	#instVars : [
		'baselines'
	],
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageBaselineDependencyStatus >> baselines [

	^ baselines
]

{ #category : #accessing }
GtPackageBaselineDependencyStatus >> baselines: anObject [

	baselines := anObject
]

{ #category : #accessing }
GtPackageBaselineDependencyStatus >> statusColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPackageBaselineDependencyStatus >> statusLabel [
	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self statusPrefix;
			space.
		
		baselines
			do: [ :eachBaselineClass | aStream print: eachBaselineClass name ]
			separatedBy: [ aStream nextPutAll: ', ' ] ]
]

{ #category : #accessing }
GtPackageBaselineDependencyStatus >> statusPrefix [
	^ self subclassResponsibility
]

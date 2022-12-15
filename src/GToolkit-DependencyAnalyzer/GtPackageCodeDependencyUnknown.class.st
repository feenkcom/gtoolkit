Class {
	#name : #GtPackageCodeDependencyUnknown,
	#superclass : #GtPackageCodeDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #testing }
GtPackageCodeDependencyUnknown >> isUnknown [
	^ true
]

{ #category : #accessing }
GtPackageCodeDependencyUnknown >> statusColor [
	^ Color green muchDarker
]

{ #category : #accessing }
GtPackageCodeDependencyUnknown >> statusLabel [
	^ ''
]

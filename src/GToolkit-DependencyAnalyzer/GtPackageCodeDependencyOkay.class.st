Class {
	#name : #GtPackageCodeDependencyOkay,
	#superclass : #GtPackageCodeDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #testing }
GtPackageCodeDependencyOkay >> isOkay [
	^ true
]

{ #category : #accessing }
GtPackageCodeDependencyOkay >> statusColor [
	^ Color green muchDarker
]

{ #category : #accessing }
GtPackageCodeDependencyOkay >> statusLabel [
	^ 'metadata'
]

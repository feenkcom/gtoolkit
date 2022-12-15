Class {
	#name : #GtPackageCodeDependencyShouldNotDepend,
	#superclass : #GtPackageCodeDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageCodeDependencyShouldNotDepend >> statusColor [
	^ Color orange darker
]

{ #category : #accessing }
GtPackageCodeDependencyShouldNotDepend >> statusLabel [
	^ 'Should not depend'
]

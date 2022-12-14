Class {
	#name : #GtPackageCodeDependencyMustNotDepend,
	#superclass : #GtPackageCodeDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageCodeDependencyMustNotDepend >> statusColor [
	^ Color red
]

{ #category : #accessing }
GtPackageCodeDependencyMustNotDepend >> statusLabel [
	^ '(!) Must not depend'
]

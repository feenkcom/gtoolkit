Class {
	#name : #GtPackageCodeDependencyNoLongerDepends,
	#superclass : #GtPackageCodeDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> statusColor [
	^ Color red darker
]

{ #category : #accessing }
GtPackageCodeDependencyNoLongerDepends >> statusLabel [
	^ 'No longer depends'
]

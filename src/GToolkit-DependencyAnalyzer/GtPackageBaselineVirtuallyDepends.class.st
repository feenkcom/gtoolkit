Class {
	#name : #GtPackageBaselineVirtuallyDepends,
	#superclass : #GtPackageBaselineDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageBaselineVirtuallyDepends >> statusColor [
	^ Color gray
]

{ #category : #accessing }
GtPackageBaselineVirtuallyDepends >> statusPrefix [
	^ 'Preloaded by'
]

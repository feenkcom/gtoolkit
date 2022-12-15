Class {
	#name : #GtPackageBaselineExplicitlyDepends,
	#superclass : #GtPackageBaselineDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageBaselineExplicitlyDepends >> statusColor [
	^ Color green muchDarker
]

{ #category : #accessing }
GtPackageBaselineExplicitlyDepends >> statusPrefix [
	^ 'Explicitly defined in'
]

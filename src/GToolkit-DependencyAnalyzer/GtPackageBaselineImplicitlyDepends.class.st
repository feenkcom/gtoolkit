Class {
	#name : #GtPackageBaselineImplicitlyDepends,
	#superclass : #GtPackageBaselineDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #accessing }
GtPackageBaselineImplicitlyDepends >> statusColor [
	^ Color yellow muchDarker
]

{ #category : #accessing }
GtPackageBaselineImplicitlyDepends >> statusPrefix [
	^ 'Indirectly defined in'
]

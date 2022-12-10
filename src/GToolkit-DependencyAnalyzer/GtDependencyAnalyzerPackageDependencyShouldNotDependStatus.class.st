Class {
	#name : #GtDependencyAnalyzerPackageDependencyShouldNotDependStatus,
	#superclass : #GtDependencyAnalyzerPackageDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyShouldNotDependStatus >> statusColor [
	^ Color orange darker
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyShouldNotDependStatus >> statusLabel [
	^ 'Should not depend'
]

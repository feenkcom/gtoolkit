Class {
	#name : #GtDependencyAnalyzerPackageDependencyNoLongerDependsStatus,
	#superclass : #GtDependencyAnalyzerPackageDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyNoLongerDependsStatus >> statusColor [
	^ Color gray
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyNoLongerDependsStatus >> statusLabel [
	^ 'No longer depends'
]

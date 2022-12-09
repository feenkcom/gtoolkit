Class {
	#name : #GtDependencyAnalyzerPackageDependencyOkayStatus,
	#superclass : #GtDependencyAnalyzerPackageDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyOkayStatus >> statusColor [
	^ Color green muchDarker
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyOkayStatus >> statusLabel [
	^ 'Okay'
]

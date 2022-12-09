Class {
	#name : #GtDependencyAnalyzerPackageDependencyMustNotDependStatus,
	#superclass : #GtDependencyAnalyzerPackageDependencyStatus,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyMustNotDependStatus >> statusColor [
	^ Color red
]

{ #category : #accessing }
GtDependencyAnalyzerPackageDependencyMustNotDependStatus >> statusLabel [
	^ '(!) Must not depend'
]

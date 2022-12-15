Class {
	#name : #GtPackageCodeDependencyStatus,
	#superclass : #Object,
	#category : #'GToolkit-DependencyAnalyzer-Status'
}

{ #category : #testing }
GtPackageCodeDependencyStatus >> isOkay [
	^ false
]

{ #category : #testing }
GtPackageCodeDependencyStatus >> isOkayOrUnknown [
	^ self isOkay or: [ self isUnknown ]
]

{ #category : #testing }
GtPackageCodeDependencyStatus >> isUnknown [
	^ false
]

{ #category : #accessing }
GtPackageCodeDependencyStatus >> statusColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPackageCodeDependencyStatus >> statusLabel [
	^ self subclassResponsibility
]

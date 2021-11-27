Class {
	#name : #GtPharoPackageDependenciesConstraint,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> actualDependenciesOf: aPackageName [
	| aPackage theActualDependencies |
	
	aPackage := aPackageName asPackage.
	theActualDependencies := ((aPackage gtDependencies collect: #toPackage) collect: #name) asSet asArray sorted.

	^ String streamContents: [ :aStream |
		aStream nextPut: ${; cr.
		theActualDependencies
			do: [ :each | aStream tab; nextPut: $'; nextPutAll: each; nextPut: $' ]
			separatedBy: [ aStream nextPut: $.; cr ].
		aStream cr; nextPut: $} ]
]

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> package: aPackageName mustDependOn: aCollectionOfPackageNames [
	| theIssues aPackage theDeclaredDependentPackages theActualDependencies |
	
	theIssues := OrderedCollection new.
	
	aPackage := aPackageName asPackageIfAbsent: [
		theIssues add: ('Package named {1} does not exist' format: { aPackageName asString printString } ).
		nil ]. 
	
	theDeclaredDependentPackages := OrderedCollection new.
	aCollectionOfPackageNames do: [ :eachPackageName |
		theDeclaredDependentPackages add: (eachPackageName asPackageIfAbsent: [
		theIssues add: ('Package named {1} does not exist' format: { eachPackageName asString printString } ).
		nil ]) ].

	(aPackage isNil or: [ theDeclaredDependentPackages anySatisfy: #isNil ])
		ifTrue: [ ^ theIssues ].
	
	theActualDependencies := (aPackage gtDependencies collect: #toPackage) asSet asArray sorted: [ :a :b | a name < b name ].

	(theActualDependencies difference: theDeclaredDependentPackages)
		do: [ :eachUndeclaredPackage |
			theIssues add: ('Package named {1} should not depend on {2}' format: {
				aPackage name asString printString.
				eachUndeclaredPackage name asString printString }) ].
		
	(theDeclaredDependentPackages difference: theActualDependencies)
		do: [ :eachUndeclaredPackage |
			theIssues add: ('Package named {1} no longer depends on {2}' format: {
				aPackage name asString printString.
				eachUndeclaredPackage name asString printString }) ].
		
	^ theIssues
]

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> package: aPackageName mustNotDependOn: aCollectionOfPackageNames [
	| theIssues aPackage theDeclaredDependentPackages theActualDependencies |
	
	theIssues := OrderedCollection new.
	
	aPackage := aPackageName asPackageIfAbsent: [
		theIssues add: ('Package named {1} does not exist' format: { aPackageName asString printString } ).
		nil ]. 
	
	theDeclaredDependentPackages := OrderedCollection new.
	aCollectionOfPackageNames do: [ :eachPackageName |
		theDeclaredDependentPackages add: (eachPackageName asPackageIfAbsent: [
		theIssues add: ('Package named {1} does not exist' format: { eachPackageName asString printString } ).
		nil ]) ].

	(aPackage isNil or: [ theDeclaredDependentPackages anySatisfy: #isNil ])
		ifTrue: [ ^ theIssues ].
	
	theActualDependencies := (aPackage gtDependencies collect: #toPackage) asSet asArray sorted: [ :a :b | a name < b name ].

	(theActualDependencies difference: theDeclaredDependentPackages)
		do: [ :eachUndeclaredPackage |
			theIssues add: ('Package named {1} must not depend on {2}' format: {
				aPackage name asString printString.
				eachUndeclaredPackage name asString printString }) ].
		
	^ theIssues
]

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> validatePackageNames: aCollectionOfPackageNames issues: theIssues [
	| theDeclaredDependentPackages |
	
	theDeclaredDependentPackages := OrderedCollection new.
	aCollectionOfPackageNames do: [ :eachPackageName |
		theDeclaredDependentPackages add: (eachPackageName asPackageIfAbsent: [
		theIssues add: ('Package named {1} does not exist' format: { eachPackageName asString printString } ).
		nil ]) ]
]

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

{ #category : #accessing }
GtPharoPackageDependenciesConstraint >> issues [
	"returns the facts that contradict the constraint"
	
	^ Array streamContents: [ :aStream |
		RPackage organizer packageNames do: [ :eachPackageName | aStream nextPutAll: (self packageIssuesOf: eachPackageName) ] ]
]

{ #category : #accessing }
GtPharoPackageDependenciesConstraint >> name [ 
	^ 'Packages should respect must only depend on dependenies'
]

{ #category : #'api - dependencies' }
GtPharoPackageDependenciesConstraint >> package: aPackage mustNotDependOn: aCollectionOfPackageNames [
	| theIssues theDeclaredDependentPackages theActualDependencies |
	theIssues := OrderedCollection new.

	theDeclaredDependentPackages := self
			packageNamesToPackages: aCollectionOfPackageNames
			issues: theIssues
			forPackage: aPackage.

	theIssues ifNotEmpty: [ ^ theIssues ].

	theActualDependencies := (aPackage gtDependencies collect: #toPackage) asSet
			asArray sorted: [ :a :b | a name < b name ].

	(theActualDependencies intersection: theDeclaredDependentPackages)
		do: [ :eachPackage | 
			theIssues
				add: ('Package named {1} must not depend on {2}'
						format: {aPackage name asString printString.
								eachPackage name asString printString}) ].

	^ theIssues
]

{ #category : #'api - dependencies' }
GtPharoPackageDependenciesConstraint >> package: aPackage mustOnlyDependOn: aCollectionOfPackageNames [
	<return: #OrderedCollection>
	| theIssues theDeclaredDependentPackages theActualDependencies |
	theIssues := OrderedCollection new.

	theDeclaredDependentPackages := self
			packageNamesToPackages: aCollectionOfPackageNames
			issues: theIssues
			forPackage: aPackage.

	theIssues ifNotEmpty: [ ^ theIssues ].

	theActualDependencies := (aPackage gtDependencies collect: #toPackage) asSet
			asArray sorted: [ :a :b | a name < b name ].

	(theActualDependencies difference: theDeclaredDependentPackages)
		do: [ :eachUndeclaredPackage | 
			theIssues
				add: ('Package named {1} must not depend on {2}'
						format: {aPackage name asString printString.
								eachUndeclaredPackage name asString printString}) ].

	(theDeclaredDependentPackages difference: theActualDependencies)
		do: [ :eachUndeclaredPackage | 
			theIssues
				add: ('Package named {1} no longer depends on {2}'
						format: {aPackage name asString printString.
								eachUndeclaredPackage name asString printString}) ].

	^ theIssues
]

{ #category : #'api - dependencies' }
GtPharoPackageDependenciesConstraint >> package: aPackage shouldDependOn: aCollectionOfPackageNames [
	<return: #OrderedCollection>
	| theIssues theDeclaredDependentPackages theActualDependencies |
	theIssues := OrderedCollection new.

	theDeclaredDependentPackages := self
			packageNamesToPackages: aCollectionOfPackageNames
			issues: theIssues
			forPackage: aPackage.

	theIssues ifNotEmpty: [ ^ theIssues ].
	theActualDependencies := (aPackage gtDependencies collect: #toPackage) asSet
			asArray sorted: [ :a :b | a name < b name ].

	(theDeclaredDependentPackages difference: theActualDependencies)
		do: [ :eachUndeclaredPackage | 
			theIssues
				add: ('Package named {1} no longer depends on {2}'
						format: {aPackage name asString printString.
								eachUndeclaredPackage name asString printString}) ].

	^ theIssues
]

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> packageIssuesOf: aPackageName [
	| aPackage aPackageManifest theIssues |
	aPackage := aPackageName
			asPackageIfAbsent: [ ^ {'Package named {1} does not exist'
						format: {aPackageName asString printString}} ].

	aPackageManifest := aPackage packageManifestOrNil ifNil: [ ^ #() ].

	theIssues := OrderedCollection new.

	[ theIssues
		addAll: (self package: aPackage mustOnlyDependOn: aPackageManifest mustOnlyDependOn) ]
		onDNU: #mustOnlyDependOn
		do: [ :ex |  ].

	[ theIssues
		addAll: (self package: aPackage mustNotDependOn: aPackageManifest mustNotDependOn) ]
		onDNU: #mustNotDependOn
		do: [ :ex |  ].

	[ theIssues
		addAll: (self package: aPackage shouldDependOn: aPackageManifest shouldDependOn) ]
		onDNU: #shouldDependOn
		do: [ :ex |  ].

	^ theIssues
]

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> packageNameToPackage: aPackageName issues: aCollectionOfIssues forPackage: aPackage [
	<return: #Collection of: #RPackage>

	^ aPackageName asPackageIfAbsent: [
		aCollectionOfIssues add: ('Package named {1} referenced by metadata of {2} does not exist' format: { aPackageName asString printString. aPackage name printString } ).
		nil ]
]

{ #category : #'private - dependencies' }
GtPharoPackageDependenciesConstraint >> packageNamesToPackages: aCollectionOfPackageNames issues: aCollectionOfIssues forPackage: aPackage [
	<return: #Collection of: #RPackage>
	| theDeclaredDependentPackages |

	theDeclaredDependentPackages := OrderedCollection new.

	aCollectionOfPackageNames do: [ :eachPackageName | 
		theDeclaredDependentPackages add: (self
			packageNameToPackage: eachPackageName
			issues: aCollectionOfIssues
			forPackage: aPackage) ].

	^ theDeclaredDependentPackages select: [ :eachPackage | eachPackage notNil ]
]

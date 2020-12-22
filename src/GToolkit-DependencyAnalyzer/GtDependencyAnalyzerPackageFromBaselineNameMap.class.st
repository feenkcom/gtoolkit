"
Allows to quickly find a package-from-baseline based on its name.

It is possible that multiple baselines define the same package, thefore we map a set of packages from baselines to a name
"
Class {
	#name : #GtDependencyAnalyzerPackageFromBaselineNameMap,
	#superclass : #Object,
	#instVars : [
		'packages'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #'instance creation' }
GtDependencyAnalyzerPackageFromBaselineNameMap class >> withPackages: aCollectionOfPackageFromBaseline [
	^ self new addPackages: aCollectionOfPackageFromBaseline
]

{ #category : #accessing }
GtDependencyAnalyzerPackageFromBaselineNameMap >> addPackage: aPackageFromBaseline [
	(packages
		at: aPackageFromBaseline name
		ifAbsentPut: [ Set new ]) add: aPackageFromBaseline
]

{ #category : #accessing }
GtDependencyAnalyzerPackageFromBaselineNameMap >> addPackages: aCollectionOfPackageFromBaseline [
	aCollectionOfPackageFromBaseline
		do: [ :eachPackageFromBaseline | self addPackage: eachPackageFromBaseline ]
]

{ #category : #testing }
GtDependencyAnalyzerPackageFromBaselineNameMap >> hasPackageNamed: aPackageName [
	^ packages includesKey: aPackageName
]

{ #category : #initialization }
GtDependencyAnalyzerPackageFromBaselineNameMap >> initialize [
	super initialize.
	
	packages := Dictionary new
]

{ #category : #accessing }
GtDependencyAnalyzerPackageFromBaselineNameMap >> packagesNamed: aPackageName [
	<return: #Set of: #GtDependencyAnalyzerForPackageFromBaseline>

	^ packages
		at: aPackageName
		ifAbsent: [ Set new ]
]

{ #category : #accessing }
GtDependencyAnalyzerPackageFromBaselineNameMap >> sortedPackagesNamed: aPackageName [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>

	^ (self packagesNamed: aPackageName) asArray sorted: [ :a :b | a name < b name ]
]

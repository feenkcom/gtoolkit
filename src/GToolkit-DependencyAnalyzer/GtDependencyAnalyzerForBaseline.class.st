Class {
	#name : #GtDependencyAnalyzerForBaseline,
	#superclass : #Object,
	#instVars : [
		'baseline',
		'cachedExplicitlyRequiredPackages',
		'cachedImplicitlyRequiredPackages'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #comparing }
GtDependencyAnalyzerForBaseline >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ baseline = anObject baseline
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> baseline [
	^ baseline
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> baseline: anObject [
	baseline := anObject
]

{ #category : #dependencies }
GtDependencyAnalyzerForBaseline >> explicitlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>

	cachedExplicitlyRequiredPackages
		ifNotNil: [ ^ cachedExplicitlyRequiredPackages ].

	^ cachedExplicitlyRequiredPackages := aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			(self baseline project version packages
				select: [  :eachPackageSpec | RPackageOrganizer default includesPackageNamed: eachPackageSpec name ]
				thenCollect: [ :eachPackageSpec |
					aGtDependencyAnalyzerContext
						package: eachPackageSpec name
						fromBaseline: self ]) as: Array ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForBaseline >> gtPackageExplicitRequirementsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Explicitly defined packages';
		priority: 10;
		items: [
			(self explicitlyDefinedPackagesWithContext: GtDependencyAnalyzerContext new)
				sorted: [ :a :b | a name < b name ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForBaseline >> gtPackageImplicitRequirementsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Implicitly defined packages';
		priority: 11;
		items: [ (self implicitlyDefinedPackagesWithContext: GtDependencyAnalyzerContext new)
			sorted: [ :a :b | a name < b name ] ]
]

{ #category : #comparing }
GtDependencyAnalyzerForBaseline >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ baseline hash
]

{ #category : #dependencies }
GtDependencyAnalyzerForBaseline >> implicitlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| theDefinedPackages |
	
	cachedImplicitlyRequiredPackages
		ifNotNil: [ ^ self ].
	
	theDefinedPackages := (self explicitlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext) asSet.

	aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			theDefinedPackages copy do: [ :eachPackage |
				theDefinedPackages addAll: (eachPackage implicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext) ]. ].

	^ cachedImplicitlyRequiredPackages := theDefinedPackages asArray
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> name [
	^ self baseline className
]

{ #category : #printing }
GtDependencyAnalyzerForBaseline >> printOn: aStream [
	aStream print: self baseline
]

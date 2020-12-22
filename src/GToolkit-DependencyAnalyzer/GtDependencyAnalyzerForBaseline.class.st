Class {
	#name : #GtDependencyAnalyzerForBaseline,
	#superclass : #Object,
	#instVars : [
		'baseline',
		'preloadedBaselines',
		'cachedDirectlyDefinedPackages',
		'cachedIndirectlyDefinedPackages'
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
GtDependencyAnalyzerForBaseline >> directlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>

	cachedDirectlyDefinedPackages
		ifNotNil: [ ^ cachedDirectlyDefinedPackages ].

	cachedDirectlyDefinedPackages := aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			(self baseline project version packages
				select: [  :eachPackageSpec | RPackageOrganizer default includesPackageNamed: eachPackageSpec name ]
				thenCollect: [ :eachPackageSpec |
					aGtDependencyAnalyzerContext
						package: eachPackageSpec name
						fromBaseline: self ]) as: Array ].

	cachedDirectlyDefinedPackages do: [ :eachPackageFromBaseline | eachPackageFromBaseline preloadedBaselines: self preloadedBaselines ].

	^ cachedDirectlyDefinedPackages asArray
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForBaseline >> gtBaselineFor: aView [
	<gtView>

	^ aView forward
		title: 'Baseline';
		priority: 15;
		object: [ (Pragma allNamed: #baseline in: BaselineOfBloc) first ];
		view: #gtSourceFor:
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForBaseline >> gtDirectlyDefinedPackagesFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Directly defined packages';
		priority: 10;
		items: [
			| aContext |
			
			aContext := GtDependencyAnalyzerContext new.
			
			((self directlyDefinedPackagesWithContext: aContext)
				sorted: [ :a :b | a name < b name ])
					collect: [ :eachPackageFromBaseline | eachPackageFromBaseline -> (eachPackageFromBaseline undefinedDependenciesWithContext: aContext) ] ];
		column: 'Package' text: [ :each |
			| aText |
			aText := each key name asRopedText.
			each value ifNotEmpty: [ aText foreground: Color red darker ].
			aText ];
		column: 'Undefined dependencies' text: [ :each | each value size ];
		send: [ :each | each key ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForBaseline >> gtIndirectlyDefinedPackagesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Idirectly defined packages';
		priority: 11;
		items: [
			(self indirectlyDefinedPackagesWithContext: GtDependencyAnalyzerContext new)
				sorted: [ :a :b | a name < b name ] ]
]

{ #category : #comparing }
GtDependencyAnalyzerForBaseline >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ baseline hash
]

{ #category : #dependencies }
GtDependencyAnalyzerForBaseline >> indirectlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| theDefinedPackages |
	
	cachedIndirectlyDefinedPackages
		ifNotNil: [ ^ self ].
	
	theDefinedPackages := (self directlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext) asSet.

	aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			theDefinedPackages copy do: [ :eachPackage |
				theDefinedPackages addAll: (eachPackage indirectlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext) ]. ].

	theDefinedPackages do: [ :eachPackageFromBaseline | eachPackageFromBaseline preloadedBaselines: self preloadedBaselines ].

	^ cachedIndirectlyDefinedPackages := theDefinedPackages asArray
]

{ #category : #initialization }
GtDependencyAnalyzerForBaseline >> initialize [
	super initialize.
	
	preloadedBaselines := #()
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> name [
	^ self baseline className
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> preloadedBaselines [
	^ preloadedBaselines
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> preloadedBaselines: anObject [
	preloadedBaselines := anObject
]

{ #category : #printing }
GtDependencyAnalyzerForBaseline >> printOn: aStream [
	aStream print: self baseline
]

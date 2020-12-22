Class {
	#name : #GtDependencyAnalyzerForPackages,
	#superclass : #Object,
	#instVars : [
		'packages',
		'preloadedBaselines'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #'instance creation' }
GtDependencyAnalyzerForPackages class >> prefixed: aPrefixStringOrArray [
	| thePrefixes |
	
	thePrefixes := aPrefixStringOrArray isString
		ifTrue: [ { aPrefixStringOrArray } ]
		ifFalse: [ aPrefixStringOrArray ].

	^ self new packages: (RPackageOrganizer default packages select: [ :eachPackage | thePrefixes anySatisfy: [ :eachPrefix | eachPackage name beginsWith: eachPrefix ] ])
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackages >> gtIssuesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Issues';
		priority: 5;
		items: [
			(self issuesWithContext: GtDependencyAnalyzerContext new)
				sorted: [ :a :b | a package name < b package name ] ];
		itemText: [ :each | each printString ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackages >> gtPackagesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Packages';
		items: [
			| aContext |
			aContext := GtDependencyAnalyzerContext new.
			(self packages collect: [ :eachPackage | eachPackage -> (eachPackage issuesWithContext: aContext) ])
				sorted: [ :a :b |
					a value size = b value size
						ifTrue: [ a key name < b key name ]
						ifFalse: [ a value size > b value size ] ] ];
		column: 'Package' text: [ :each |
			| aText |
			aText := each key name asRopedText.
			each value isNotEmpty
				ifTrue: [ aText foreground: Color red darker ].
			aText ];
		column: 'Issues' text: [ :each | each value size ];
		send: [ :each | each key ]
]

{ #category : #initialization }
GtDependencyAnalyzerForPackages >> initialize [
	super initialize.
	
	preloadedBaselines := #()
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackages >> issuesWithContext: aContext [
	^ self packages flatCollect: [ :eachPackage | eachPackage issuesWithContext: aContext ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackages >> packages [
	^ packages
]

{ #category : #accessing }
GtDependencyAnalyzerForPackages >> packages: aCollectionOfRPackage [
	packages := aCollectionOfRPackage collect: [ :eachPackage | GtDependencyAnalyzerForPackage new package: eachPackage ].
	self packages do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackages >> preloadedBaselines [
	^ preloadedBaselines
]

{ #category : #accessing }
GtDependencyAnalyzerForPackages >> preloadedBaselines: aCollectionOfBaselines [
	preloadedBaselines := aCollectionOfBaselines.
	self packages do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ]
]

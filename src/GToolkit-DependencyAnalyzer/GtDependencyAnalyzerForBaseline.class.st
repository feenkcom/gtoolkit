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
		priority: 12;
		items: [
			(self indirectlyDefinedPackagesWithContext: GtDependencyAnalyzerContext new)
				sorted: [ :a :b | a name < b name ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForBaseline >> gtIssuesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Issues';
		priority: 11;
		items: [
			(self issuesWithContext: GtDependencyAnalyzerContext new)
				sorted: [ :a :b | a package name < b package name ] ];
		itemText: [ :each | each printString ]
]

{ #category : #accessing }
GtDependencyAnalyzerForBaseline >> gtPreloadedBaselinesFor: aView [
	<gtView>
	preloadedBaselines ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Preloaded baselines';
		items: [ self preloadedBaselines asOrderedCollection ]
]

{ #category : #comparing }
GtDependencyAnalyzerForBaseline >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ baseline hash
]

{ #category : #dependencies }
GtDependencyAnalyzerForBaseline >> indirectlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| theDirectlyDefinedPackages theIndirectlyDefinedPackages |
	
	cachedIndirectlyDefinedPackages
		ifNotNil: [ ^ self ].
	
	theDirectlyDefinedPackages := (self directlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext) asSet.
	theIndirectlyDefinedPackages := Set new.
	theIndirectlyDefinedPackages addAll: theDirectlyDefinedPackages.

	aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			theDirectlyDefinedPackages do: [ :eachPackage |
				theIndirectlyDefinedPackages addAll: (eachPackage indirectlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext) ]. ].
		
	aGtDependencyAnalyzerContext
		visitBaseline: self
		during: [
			self baseline project version projects
				reject: [ :eachProjectSpec | theDirectlyDefinedPackages anySatisfy: [ :eachPackage | eachPackage packageRequirements anySatisfy: [ :eachPackageRequirement | eachPackageRequirement requiredBaseline name = eachProjectSpec className ] ] ]
				thenDo: [ :eachProjectSpec |
					(self class environment includesKey: eachProjectSpec className asSymbol)
						ifTrue: [
							theIndirectlyDefinedPackages addAll: (GtDependencyAnalyzerForBaselineOfProject new
								baseline: (self class environment at: eachProjectSpec className asSymbol);
								baselineOfProject: eachProjectSpec;
								indirectlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext) ] ] ].

	theIndirectlyDefinedPackages do: [ :eachPackageFromBaseline | eachPackageFromBaseline preloadedBaselines: self preloadedBaselines ].

	^ cachedIndirectlyDefinedPackages := theIndirectlyDefinedPackages asArray
]

{ #category : #initialization }
GtDependencyAnalyzerForBaseline >> initialize [
	super initialize.
	
	preloadedBaselines := #()
]

{ #category : #dependencies }
GtDependencyAnalyzerForBaseline >> issuesWithContext: aContext [
	^ (self directlyDefinedPackagesWithContext: aContext)
		flatCollect: [ :eachPackage | eachPackage issuesWithContext: aContext ]
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

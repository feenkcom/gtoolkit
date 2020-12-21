Class {
	#name : #GtDependencyAnalyzerForPackageFromBaseline,
	#superclass : #Object,
	#instVars : [
		'preloadedBaselines',
		'baselineAnalyzer',
		'packageAnalyzer',
		'cachedPackageRequirements',
		'cachedExplicitlyRequiredPackages',
		'cachedImplicitlyRequiredPackages'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #'instance creation' }
GtDependencyAnalyzerForPackageFromBaseline class >> package: aPackageName baseline: aBaselineClass [
	^ self new
		forBaseline: (GtDependencyAnalyzerForBaseline new baseline: aBaselineClass)
		andPackage: (GtDependencyAnalyzerForPackage new package: aPackageName asPackage)
]

{ #category : #comparing }
GtDependencyAnalyzerForPackageFromBaseline >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ baselineAnalyzer = anObject baselineAnalyzer
		and: [ packageAnalyzer = anObject packageAnalyzer ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> baseline [
	<return: #'BaselineOf class'>

	^ baselineAnalyzer baseline
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> baselineAnalyzer [
	<return: #GtDependencyAnalyzerForBaseline>

	^ baselineAnalyzer
]

{ #category : #private }
GtDependencyAnalyzerForPackageFromBaseline >> computePackageRequirements [
	| thePackageSpec aVersion |

	aVersion := self baseline project version.
	thePackageSpec := aVersion packageNamed: self package name.
	^ thePackageSpec requires collect: [ :eachRequire |
		aVersion packages
			detect: [ :eachPackage | eachPackage name = eachRequire ]
			ifFound: [ :aPackageRequire |
				GtDependencyAnalyzerPackagePackageRequirement new
					packageFromBaseline: self;
					requiredPackageFromBaselineAnalyzer: (GtDependencyAnalyzerForPackageFromBaseline new
						forBaseline: self baselineAnalyzer
						andPackage: (GtDependencyAnalyzerForPackage new package: aPackageRequire name asPackage)) ]
			ifNone: [
				aVersion projects
					detect: [ :eachProjectSpec | eachProjectSpec name = eachRequire ]
					ifFound: [ :projectSpec |
						GtDependencyAnalyzerPackageBaselineRequirement new
							packageFromBaseline: self;
							requirementBaselineAnalyzer: (GtDependencyAnalyzerForBaseline new
								baseline: (self class environment at: projectSpec className asSymbol)) ]
					ifNone: [ self error: 'Baseline is invalid' ] ] ]
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> explicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	
	cachedExplicitlyRequiredPackages
		ifNotNil: [ ^ cachedExplicitlyRequiredPackages ].
	
	^ cachedExplicitlyRequiredPackages := aGtDependencyAnalyzerContext
		visitPackage: packageAnalyzer
		during: [
			(self packageRequirements
				flatCollect: [ :eachRequirement | eachRequirement explicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext ] as: Set) asArray ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> forBaseline: aGtDependencyAnalyzerForBaseline andPackage: aGtDependencyAnalyzerForPackage [
	baselineAnalyzer := aGtDependencyAnalyzerForBaseline.
	packageAnalyzer := aGtDependencyAnalyzerForPackage
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtExplicitlyRequiredPackagesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Explicitly required packages';
		priority: 11;
		items: [ (self explicitlyRequiredPackagesWithContext: GtDependencyAnalyzerContext new)
			sorted: [ :a :b | a name < b name ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtImplicitlyRequiredPackagesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Implicitly required packages';
		priority: 12;
		items: [ (self implicitlyRequiredPackagesWithContext: GtDependencyAnalyzerContext new)
			sorted: [ :a :b | a name < b name ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtPackageDependenciesFor: aView [
	<gtView>
	| allExplicitlyRequiredPackages allImplicitlyRequiredPackages allPreloadedPackages aContext |
	
	aContext := GtDependencyAnalyzerContext new.
	
	allExplicitlyRequiredPackages := ((self explicitlyRequiredPackagesWithContext: aContext)
		collect: [ :eachPackage | eachPackage name -> eachPackage ]) as: Dictionary.

	allImplicitlyRequiredPackages := ((self implicitlyRequiredPackagesWithContext: aContext)
		collect: [ :eachPackage | eachPackage name -> eachPackage ]) as: Dictionary.
		
	allPreloadedPackages := ((self preloadedPackagesWithContext: aContext)
		collect: [ :eachPackage | eachPackage name -> eachPackage ]) as: Dictionary.
	
	^ aView columnedList
		title: 'Package dependencies';
		priority: 10;
		items: [ (self packageDependencies sorted: [ :a :b | a package name < b package name ])
			collect: [ :each |
				(allExplicitlyRequiredPackages includesKey: each package name)
					ifTrue: [ { each . allExplicitlyRequiredPackages at: each package name } -> { Color green muchDarker . 'explictly defined' } ]
					ifFalse: [
						(allImplicitlyRequiredPackages includesKey: each package name)
							ifTrue: [ { each . allImplicitlyRequiredPackages at: each package name }-> { Color yellow muchDarker . 'implicitly defined' } ]
							ifFalse: [ (allPreloadedPackages includesKey: each package name)
								ifTrue: [ { each . allPreloadedPackages at: each package name }-> { Color gray . 'preloaded' } ]
								ifFalse: [ { each . nil } -> { Color red darker. 'undefined' } ] ] ] ]	 ];
		column: 'Package' text: [ :each |
			each key first package name asRopedText foreground: each value first ];
		column: 'Dependency' do: [ :column |
			column
				cellStencil: [
					BrEditor new
						fitContent;
						look: BrGlamorousEditorLook;
						beReadOnlyWithSelection;
						padding: BlInsets empty ];
				dataBinder: [ :element :each |
					| eachText |
					
					eachText := each value second asRopedText glamorousRegularFont.
					each key second
						ifNotNil: [ eachText, ' in ' asRopedText glamorousRegularFont, each key second baseline printString asRopedText glamorousCodeFont glamorousRoundedBackground ].
					
					allExplicitlyRequiredPackages
						at: each key first package name	
						ifPresent: [ :package |
							package baseline = self baseline
								ifFalse: [ eachText, ' from ' asRopedText glamorousRegularFont, self baseline printString asRopedText glamorousCodeFont glamorousRoundedBackground ] ].
					
					element text: eachText ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtPackageRequirementsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Defined requirements';
		priority: 20;
		items: [ self packageRequirements ]
]

{ #category : #comparing }
GtDependencyAnalyzerForPackageFromBaseline >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ baselineAnalyzer hash bitXor: packageAnalyzer hash
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> implicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	
	cachedImplicitlyRequiredPackages
		ifNotNil: [ ^ cachedImplicitlyRequiredPackages ].

	^ cachedImplicitlyRequiredPackages := aGtDependencyAnalyzerContext
		visitPackage: packageAnalyzer
		during: [
			(self packageRequirements
				flatCollect: [ :eachRequirement | eachRequirement implicitlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext ] as: Set) asArray ]
]

{ #category : #initialization }
GtDependencyAnalyzerForPackageFromBaseline >> initialize [
	super initialize.
	
	preloadedBaselines := #()
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> name [
	^ self package name
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> package [
	<return: #RPackage>

	^ packageAnalyzer package
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> packageAnalyzer [
	<return: #GtDependencyAnalyzerForPackage>

	^ packageAnalyzer
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> packageDependencies [
	^ packageAnalyzer packageDependencies
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> packageRequirements [
	^ cachedPackageRequirements ifNil: [ cachedPackageRequirements := self computePackageRequirements ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> preloadedBaselines [
	^ preloadedBaselines
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> preloadedBaselines: anObject [
	preloadedBaselines := anObject asSet
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> preloadedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| thePreloadedPackages |
	
	thePreloadedPackages := Set new.
	self preloadedBaselines do: [ :eachClass |
		thePreloadedPackages addAll: ((GtDependencyAnalyzerForBaseline new baseline: eachClass)
			implicitlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext) ].

	^ thePreloadedPackages asArray
]

{ #category : #printing }
GtDependencyAnalyzerForPackageFromBaseline >> printOn: aStream [
	aStream
		print: self package name;
		nextPutAll: ' from ';
		print: self baseline
]

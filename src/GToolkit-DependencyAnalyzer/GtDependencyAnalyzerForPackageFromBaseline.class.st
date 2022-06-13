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
GtDependencyAnalyzerForPackageFromBaseline >> computePackageRequirementsWithContext: aContext [
	| thePackageSpec aVersion |

	aVersion := self baseline project version.
	thePackageSpec := aVersion packageNamed: self package name.
	thePackageSpec
		ifNil: [ ^ #() ].

	^ thePackageSpec requires collect: [ :eachRequire |
		aVersion packages
			detect: [ :eachPackage | eachPackage name = eachRequire ]
			ifFound: [ :aPackageRequire |
				GtDependencyAnalyzerPackagePackageRequirement new
					packageFromBaseline: self;
					requiredPackageFromBaselineAnalyzer: (GtDependencyAnalyzerForPackageFromBaseline new
						forBaseline: self baselineAnalyzer
						andPackage: (GtDependencyAnalyzerForPackage new 
							package: aPackageRequire name asPackage; 
							preloadedBaselines: self preloadedBaselines)) ]
			ifNone: [
				aVersion projects
					detect: [ :eachProjectSpec | eachProjectSpec name = eachRequire ]
					ifFound: [ :projectSpec |
						GtDependencyAnalyzerPackageBaselineRequirement new
							packageFromBaseline: self;
							requirementBaselineAnalyzer: (aContext dependencyAnalyzerForBaseline: (
								self class environment at: projectSpec className asSymbol)) ]
					ifNone: [ self error: 'Baseline is invalid' ] ] ]
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> directlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	
	cachedExplicitlyRequiredPackages
		ifNotNil: [ ^ cachedExplicitlyRequiredPackages ].
	
	cachedExplicitlyRequiredPackages := aGtDependencyAnalyzerContext
		visitPackage: packageAnalyzer
		during: [
			((self packageRequirementsWithContext: aGtDependencyAnalyzerContext)
				flatCollect: [ :eachRequirement | eachRequirement directlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext ] as: Set) asArray ].

	cachedExplicitlyRequiredPackages do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ].

	^ cachedExplicitlyRequiredPackages 
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> forBaseline: aGtDependencyAnalyzerForBaseline andPackage: aGtDependencyAnalyzerForPackage [
	baselineAnalyzer := aGtDependencyAnalyzerForBaseline.
	packageAnalyzer := aGtDependencyAnalyzerForPackage
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtBaselineFor: aView [
	<gtView>

	^ aView forward
		title: 'Baseline';
		priority: 15;
		object: [ self baselineAnalyzer ];
		view: #gtBaselineFor:
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtExplicitlyRequiredPackagesFor: aView context: aPhlowContext [
	<gtView>
	
	| aContext |
	aContext := aPhlowContext 
		at: #GtDependencyAnalyzerContext 
		ifAbsentPut: [ GtDependencyAnalyzerContext new ].
		
	^ aView list
		title: 'Explicitly required packages';
		priority: 11;
		items: [ (self directlyRequiredPackagesWithContext: aContext)
			sorted: [ :a :b | a name < b name ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtImplicitlyRequiredPackagesFor: aView context: aPhlowContext [
	<gtView>

	| aContext |
	aContext := aPhlowContext 
		at: #GtDependencyAnalyzerContext 
		ifAbsentPut: [ GtDependencyAnalyzerContext new ].
			
	^ aView list
		title: 'Implicitly required packages';
		priority: 12;
		items: [ (self indirectlyRequiredPackagesWithContext: aContext)
			sorted: [ :a :b | a name < b name ] ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtPackageDependenciesFor: aView context: aPhlowContext [
	<gtView>
	| allExplicitlyRequiredPackages allImplicitlyRequiredPackages allPreloadedPackages aContext |
	
	aContext := aPhlowContext 
		at: #GtDependencyAnalyzerContext 
		ifAbsentPut: [ GtDependencyAnalyzerContext new ].
	
	allExplicitlyRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap
		withPackages: (self directlyRequiredPackagesWithContext: aContext).

	allImplicitlyRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap
		withPackages: (self indirectlyRequiredPackagesWithContext: aContext).

	allPreloadedPackages := GtDependencyAnalyzerPackageFromBaselineNameMap
		withPackages: (self preloadedPackagesWithContext: aContext).

	^ aView columnedList
		title: 'Package dependencies';
		priority: 10;
		items: [ (self packageDependencies sorted: [ :a :b | a package name < b package name ])
			collect: [ :each |
				(allExplicitlyRequiredPackages hasPackageNamed: each package name)
					ifTrue: [ { each . allExplicitlyRequiredPackages sortedPackagesNamed: each package name } -> { Color green muchDarker . 'directly defined' } ]
					ifFalse: [
						(allImplicitlyRequiredPackages hasPackageNamed: each package name)
							ifTrue: [ { each . allImplicitlyRequiredPackages sortedPackagesNamed: each package name }-> { Color yellow muchDarker . 'indirectly defined' } ]
							ifFalse: [ (allPreloadedPackages hasPackageNamed: each package name)
								ifTrue: [ { each . allPreloadedPackages sortedPackagesNamed: each package name } -> { Color gray . 'preloaded' } ]
								ifFalse: [ { each . #() } -> { Color red darker. 'undefined' } ] ] ] ]	 ];
		column: 'Package' text: [ :each |
			each key first package name asRopedText foreground: each value first ] weight: 0.5;
		column: 'Dependency' do: [ :column |
			column
				cellStencil: [
					BrEditor new
						fitContent;
						aptitude: BrGlamorousEditorAptitude;
						beReadOnlyWithSelection;
						padding: BlInsets empty ];
				dataBinder: [ :element :each |
					| eachText |
					
					eachText := each value second asRopedText glamorousRegularFont.
					each key second
						ifNotEmpty: [ eachText append:' in ' asRopedText glamorousRegularFont ].
					each key second
						do: [ :eachPackageFromBaseline |
							eachText append: eachPackageFromBaseline baseline printString asRopedText glamorousCodeFont glamorousCodeSmallSize glamorousRoundedBackground.
							
							((allExplicitlyRequiredPackages hasPackageNamed: eachPackageFromBaseline name)
								and: [ eachPackageFromBaseline baseline ~= self baseline ])
									ifTrue: [ eachText, ' from ' asRopedText glamorousRegularFont, self baseline printString asRopedText glamorousCodeSmallSize glamorousCodeFont glamorousRoundedBackground ] ]
						separatedBy: [ eachText append: ' and ' asRopedText glamorousRegularFont ].
					
					element text: eachText ] ];
		send: [ :each |
			each key second
				ifEmpty: [ each key first ]
				ifNotEmpty: [ each key second size = 1
					ifTrue: [ each key second anyOne ]
					ifFalse: [ each key second ] ]  ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> gtPackageDependentsFor: aView [

	<gtView>
	^ aView forward
			title: 'Package dependents';
			priority: 11;
			object: [ packageAnalyzer ];
			view: #gtPackageDependentsFor:
	
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtPackageRequirementsFor: aView context: aPhlowContext [
	<gtView>
	
	| aContext |
	aContext := aPhlowContext 
		at: #GtDependencyAnalyzerContext 
		ifAbsentPut: [ GtDependencyAnalyzerContext new ].
	
	^ aView list
		title: 'Defined requirements';
		priority: 20;
		items: [ self packageRequirementsWithContext: aContext ]
]

{ #category : #'gt-extensions' }
GtDependencyAnalyzerForPackageFromBaseline >> gtPreloadedBaselinesFor: aView [
	<gtView>
	preloadedBaselines ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Preloaded baselines';
		items: [ self preloadedBaselines asOrderedCollection ]
]

{ #category : #'gt-extension' }
GtDependencyAnalyzerForPackageFromBaseline >> gtSuggestedBaselinesFor: aView context: aPhlowContext [

	<gtView>
	| allExplicitlyRequiredPackages allImplicitlyRequiredPackages allPreloadedPackages aContext allPackages |

	aContext := aPhlowContext 
		at: #GtDependencyAnalyzerContext 
		ifAbsentPut: [ GtDependencyAnalyzerContext new ].

	allExplicitlyRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap 
		                                 withPackages:
		                                 (self 
			                                  directlyRequiredPackagesWithContext:
			                                  aContext).

	allImplicitlyRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap 
		                                 withPackages:
		                                 (self 
			                                  indirectlyRequiredPackagesWithContext:
			                                  aContext).

	allPreloadedPackages := GtDependencyAnalyzerPackageFromBaselineNameMap 
		                        withPackages:
		                        (self preloadedPackagesWithContext: aContext).

	allPackages := (allExplicitlyRequiredPackages union:
		                allImplicitlyRequiredPackages) union:
		               allPreloadedPackages.

	^ aView columnedList
		  title: 'Suggested Baselines';
		  priority: 10;
		  items: [ 
			  (self packageDependencies sorted: [ :a :b | 
					   a package name < b package name ]) select: [ :each | 
					  (allPackages hasPackageNamed: each package name) not ] ];
		  column: 'Missing Package' text: [ :each | each package name ];
		  column: 'Defining Baselines' text: [ :each | 
			  ((each definingBaselinesWithContext:
					    GtDependencyAnalyzerContext new) collect: #baseline) joinUsing: ', ' ]
]

{ #category : #comparing }
GtDependencyAnalyzerForPackageFromBaseline >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ baselineAnalyzer hash bitXor: packageAnalyzer hash
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> indirectlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	
	cachedImplicitlyRequiredPackages
		ifNotNil: [ ^ cachedImplicitlyRequiredPackages ].

	cachedImplicitlyRequiredPackages := aGtDependencyAnalyzerContext
		visitPackage: packageAnalyzer
		during: [
			((self packageRequirementsWithContext: aGtDependencyAnalyzerContext)
				flatCollect: [ :eachRequirement | eachRequirement indirectlyRequiredPackagesWithContext: aGtDependencyAnalyzerContext ] as: Set) asArray ].
	
	cachedImplicitlyRequiredPackages do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ].
	
	^ cachedImplicitlyRequiredPackages
]

{ #category : #initialization }
GtDependencyAnalyzerForPackageFromBaseline >> initialize [
	super initialize.
	
	preloadedBaselines := #()
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> issuesWithContext: aContext [
	^ ((self undefinedDependenciesWithContext: aContext) sorted: [ :a :b | a name < b name ])
		collect: [ :eachDependency | 
			GtDependencyAnalyzerPackageHasUndefinedDependenciesIssue new
				package: self;
				undefinedDependency: eachDependency ]
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
	"Code dependencies such as class references, trait usages"

	^ packageAnalyzer packageDependencies
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> packageRequirementsWithContext: aContext [
	^ cachedPackageRequirements ifNil: [ 
			cachedPackageRequirements := self computePackageRequirementsWithContext: aContext ]
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> preloadedBaselines [
	^ preloadedBaselines
]

{ #category : #accessing }
GtDependencyAnalyzerForPackageFromBaseline >> preloadedBaselines: aCollection [
	preloadedBaselines := aCollection asSet.
	
	baselineAnalyzer ifNotNil: [ baselineAnalyzer preloadedBaselines: aCollection ].
	packageAnalyzer ifNotNil: [ packageAnalyzer preloadedBaselines: aCollection ].
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> preloadedPackagesWithContext: aGtDependencyAnalyzerContext [
	<return: #Array of: #GtDependencyAnalyzerForPackageFromBaseline>
	| thePreloadedPackages |
	
	thePreloadedPackages := Set new.
	self preloadedBaselines do: [ :eachClass |
		thePreloadedPackages addAll: ((aGtDependencyAnalyzerContext dependencyAnalyzerForBaseline: eachClass)
			indirectlyDefinedPackagesWithContext: aGtDependencyAnalyzerContext) ].

	thePreloadedPackages do: [ :eachPackage | eachPackage preloadedBaselines: self preloadedBaselines ].

	^ thePreloadedPackages asArray
]

{ #category : #printing }
GtDependencyAnalyzerForPackageFromBaseline >> printOn: aStream [
	aStream
		print: self package name;
		nextPutAll: ' from ';
		print: self baseline
]

{ #category : #dependencies }
GtDependencyAnalyzerForPackageFromBaseline >> undefinedDependenciesWithContext: aContext [
	| allRequiredPackages |
		
	allRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap new
		addPackages: (self directlyRequiredPackagesWithContext: aContext);
		addPackages: (self indirectlyRequiredPackagesWithContext: aContext);
		addPackages: (self preloadedPackagesWithContext: aContext);
		yourself.
		
	^ self packageDependencies reject: [ :eachDependency |
		allRequiredPackages hasPackageNamed: eachDependency name ]
]

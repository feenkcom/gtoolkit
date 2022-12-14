Extension { #name : #RPackage }

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtClassHierarchyFor: aView [
	<gtPackageView>
	^ aView mondrian
		title: 'Classes Map';
		priority: 10.6;
		tooltip: 'Classes: black, Traits: orange, Extended classes: gray';
		painting: [ :aMondrian | self paintClassHierarchyWith: aMondrian ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtDependenciesMapFor: aView [
	"<gtView>"
	^ aView mondrian
	title: 'Dependencies Map';
	priority: 10;
	painting: [ :mondrian |
		mondrian nodes 
			shape: [ :each | 
				BrLabel new 
					text: each name asRopedText;
					aptitude: BrGlamorousLabelAptitude
			];
		  with: (self gtPackagesUsed, {self}).
		mondrian edges 
			shape: [ 
				BlParabollaArcElement new 
					zIndex: 0;
					curvatureFraction: 0.1;
					border: (BlBorder paint: (Color gray alpha: 0.1) width:2 );
					toHead: (BlArrowheadSimpleArrow new
						border: (BlBorder builder paint: (Color gray alpha: 0.1); width:2; build)) ];
			fromRightCenter;
			toLeftCenter;
			connectFrom: #yourself
			toAll: [ :each | |usedPackages | 
				usedPackages := each gtPackagesUsed].
		mondrian layout custom: (GtGraphHorizontalDominanceTreeLayout new).
	]
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtDependenciesStatusByAnalyzer [
	| mustNotDependOn mustOnlyDependOn theDependenciesByPackage shouldDependOn anAnalyzer anAnalyzerContext allExplicitlyRequiredPackages allImplicitlyRequiredPackages allPreloadedPackages allDependenciesWithStatus |

	"definitely must not depend on the package"
	mustNotDependOn := (self gtDeclaredMustNotDependOn ifNil: [ #() ]) asSet.
	shouldDependOn := (self gtDeclaredShouldDependOn ifNil: [ #() ]) asSet.
	mustOnlyDependOn := self gtDeclaredMustOnlyDependOn
			ifNotNil: [ :anArray | anArray asSet ].

	theDependenciesByPackage := self gtDependencies groupedBy: [ :each | each toPackage ].
	theDependenciesByPackage := ((theDependenciesByPackage associations
			collect: [ :eachDependency | 
				| eachDependencyStatus |
				
				eachDependencyStatus := GtPackageDependencyStatus new
					package: self;
					dependencyPackage: eachDependency key;
					dependencies: eachDependency value.				
				
				(mustNotDependOn includes: eachDependency key)
					ifTrue: [ eachDependencyStatus codeMustNotDepend ]
					ifFalse: [ (mustOnlyDependOn isNotNil
							and: [ (mustOnlyDependOn includes: eachDependency key) not ])
							ifTrue: [ eachDependencyStatus codeShouldNotDepend ]
							ifFalse: [ mustOnlyDependOn ifNotNil: [ eachDependencyStatus codeOkay ] ] ].

				eachDependencyStatus ])
			collect: [ :each | each dependencyPackage -> each ]) asDictionary.

	shouldDependOn
		do: [ :eachPackage | 
			theDependenciesByPackage
				at: eachPackage
				ifAbsentPut: [ GtPackageCodeDependencyNoLongerDepends new
						package: self;
						dependencyPackage: eachPackage;
						dependencies: #() ] ].
				
	anAnalyzer := GtDependencyAnalyzerEasy analyzePackageNamed: self name.
	anAnalyzerContext := GtDependencyAnalyzerContext new.
	
	allExplicitlyRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap
		withPackages: (anAnalyzer directlyRequiredPackagesWithContext: anAnalyzerContext).

	allImplicitlyRequiredPackages := GtDependencyAnalyzerPackageFromBaselineNameMap
		withPackages: (anAnalyzer indirectlyRequiredPackagesWithContext: anAnalyzerContext).

	allPreloadedPackages := GtDependencyAnalyzerPackageFromBaselineNameMap
		withPackages: (anAnalyzer preloadedPackagesWithContext: anAnalyzerContext).

	allDependenciesWithStatus := theDependenciesByPackage values.
	allDependenciesWithStatus do: [ :eachDependency |
		(allExplicitlyRequiredPackages hasPackageNamed: eachDependency dependencyPackageName)
			ifTrue: [ eachDependency explicitBaselines: (allExplicitlyRequiredPackages baselinesForPackageNamed: eachDependency dependencyPackageName) ].
		(allImplicitlyRequiredPackages hasPackageNamed: eachDependency dependencyPackageName)
			ifTrue: [ eachDependency implicitBaselines: (allImplicitlyRequiredPackages baselinesForPackageNamed: eachDependency dependencyPackageName) ].
		(allPreloadedPackages hasPackageNamed: eachDependency dependencyPackageName)
			ifTrue: [ eachDependency preloadedBaselines: (allPreloadedPackages baselinesForPackageNamed: eachDependency dependencyPackageName) ] ].

	^ allDependenciesWithStatus
		sorted: [ :a :b | a dependencyPackageName < b dependencyPackageName ]
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtDependencyAnalyzerFor: aView [
	<gtPackageView>
	
	| anAnalyzer |
	^ aView explicit
		title: 'Dependency Analysis';
		priority: 40;
		stencil: [ 
			| anObjectHolder |
			anAnalyzer := GtDependencyAnalyzerEasy analyzePackageNamed: self name.
			anObjectHolder := GtInspectorObject new object: anAnalyzer; viewSelector: #gtPackageDependenciesFor:context:.
			GtInspector new objectHolder: anObjectHolder ];
		actionButtonIcon: BrGlamorousVectorIcons refresh 
			tooltip: 'Update dependency analysis' 
			action: [ :aButton :aTab | 
				aButton disable.
				[ aTab viewContentElement phlow syncUpdate ] asAsyncPromise 
					then: [ :aResult | aButton enable ] 
					otherwise: [ :anError | aButton enable ] ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect dependency analyzer' 
			action: [ :aButton | anAnalyzer ifNotNil: [ 
				aButton phlow spawnObject: anAnalyzer ] ]
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtDependencyTreeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Dependencies';
		priority: 2;
		items: [ self gtDependenciesStatusByAnalyzer ];
		column: 'Package'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus dependencyPackageName asRopedText
					foreground: eachDependencyStatus statusColor ]
			weight: 0.5;
		column: 'Baseline'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus baselineStatusLabel asRopedText ];
		column: 'Dependencies'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus amountOfDependencies asRopedText
					foreground: eachDependencyStatus statusColor ]
			width: 100;
		column: 'Status'
			text: [ :eachDependencyStatus | 
				eachDependencyStatus statusLabel asRopedText
					foreground: eachDependencyStatus statusColor ]
			width: 220
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtExamplesFor: aView context: aPhlowContext [
	<gtView>
	<gtPackageView>
	
	| anExampleViewModel |

	anExampleViewModel := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtExamplesForContext
			inPhlowContext: aPhlowContext.

	^ aView explicit
		title: 'Examples';
		priority: 11;
		stencil: [ | aCollection aGroup aGroupView anElement |
			aCollection := self gtExamplesAllContained
					collect: [ :eachExample | eachExample asCachedExampleWithResult ].
			aGroup := GtExampleGroup withAll: aCollection.
			aGroupView := GtPhlowView empty on: aGroup perform: #gtExamplesFor:.
			anElement := aGroupView asElement.
			anElement userData at: #gtExamplesFor: put: aGroup.
			anExampleViewModel pharoExampleSuite stream: aCollection asAsyncStream.
			anElement ];
		actionStencil: [ :aBrTab | 
			GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionUpdateButtonTooltip: 'Update example list'.
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtPackageDependentsFor: aView [
	"<gtView>"
	
	^ aView forward
		title: 'Package dependents';
		priority: 3;
		object: [ GtDependencyAnalyzerForPackage packageNamed: self name ];
		view: #gtPackageDependentsFor:
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtPackageOverviewFor: aView [
	<gtView>
	<gtPackageView>
	^ aView explicit
		title: 'Overview';
		priority: 1.5;
		stencil: [ GtPharoPackageOverviewElement new package: self ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtTagAndClassHierarchyFor: aView [
	"<gtView>"
	<gtPackageView>
	^ aView mondrian
		title: 'Tags Map';
		priority: 10.7;
		tooltip: 'Classes: black, Traits: orange';
		painting: [ :aMondrian | self paintTagAndClassHierarchyWith: aMondrian ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtTestsFor: aView context: aPhlowConetxt [
	<gtView>
	<gtPackageView>
	
	^ (GtPharoCoderUIUtility
		testMethodsPhlowViewFor: aView
		context: aPhlowConetxt
		filter: (GtSearchPackageTestSuiteFilter new package: self))
			title: 'Tests';
			priority: 12
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> paintClassHierarchyWith: aMondrian [

	| aModel |
	aModel := self classes.
	aMondrian nodes
		shape: [ :aClass | 
			BrButton new
				fitContent;
				aptitude: (BrGlamorousLabelAptitude new
						 foreground: (aClass isTrait
								  ifTrue: [ Color orange ]
								  ifFalse: [ 
									  (self extendedClasses includes: aClass)
										  ifTrue: [ Color gray ]
										  ifFalse: [ Color black ] ]);
						 glamorousRegularFont;
						 fontSize: 5);
				label: aClass name;
				action: [ :aButton | 
					aButton phlow spawnTool: (GtClassCoderTool forClass: aClass) ] ];
		with: aModel.
	aMondrian edges
		shape: [ :x | 
			BlLineElement new border:
					(BlBorder paint: (Color orange alpha: 0.5) width: 1) ];
		connect: (aModel select: #isTrait)
		from: [ :aTrait | aTrait ]
		toAll: [ :aTrait | aTrait users asOrderedCollection ].

	aMondrian edges
		shape: [ :x | 
			| aColor |
			aColor := (self extendedClasses includes: x)
				          ifTrue: [ Color gray alpha: 0.5 ]
				          ifFalse: [ Color black alpha: 0.5 ].
			BlLineElement new border: (BlBorder paint: aColor width: 1) ];
		connect: (aModel reject: #isTrait)
		from: [ :aTrait | aTrait ]
		toAll: [ :aTrait | aTrait subclasses asOrderedCollection ].

	aMondrian layout force
		strength: 0.15;
		charge: -250;
		length: 70.
	aMondrian
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> paintTagAndClassHierarchyWith: aMondrian [

	| aModel |
	aModel := self classTags.
	aMondrian nodes
		shape: [ :aTag | 
			BrVerticalPane new
				addAptitude: BrShadowAptitude;
				margin: (BlInsets all: 10);
				background: Color white;
				fitContent;
				when: BlClickEvent do: [ :anEvent | 
					anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder:
									 ((GtPharoPackageTagCoder forPackageTag: aTag) packageCoder:
											  (GtPharoPackageCoder forPackage: self))) ];
				addChild: (BrLabel new
						 fitContent;
						 beTinySize;
						 aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
						 margin: (BlInsets bottom: 10);
						 text: aTag name);
				addChild: (BlElement new
						 constraintsDo: [ :c | 
							 c horizontal fitContent.
							 c vertical fitContent ];
						 when: BlClickEvent do: [ :anEvent | 
							 anEvent currentTarget phlow spawnTool:
									 (GtReadyCoderTool coder:
											  ((GtPharoPackageTagCoder forPackageTag: aTag) 
												   packageCoder: (GtPharoPackageCoder forPackage: self))) ];
						 in: [ :theElement | 
							 theElement graph beChildrenContainer: #default ];
						 yourself) ];
		with: aModel forEach: [ :aTag | 
		aMondrian nodes
			shape: [ :aClass | 
				BrButton new
					fitContent;
					aptitude: (BrGlamorousLabelAptitude new
							 foreground: (aClass isTrait
									  ifTrue: [ Color orange ]
									  ifFalse: [ Color black ]);
							 glamorousRegularFont;
							 fontSize: 10);
					label: aClass name;
					action: [ :aButton | 
						aButton phlow spawnTool: (GtClassCoderTool forClass: aClass) ] ];
			with: aTag classes.

		aMondrian edges
			shape: [ :x | 
				BlLineElement new border:
						(BlBorder paint: (Color orange alpha: 0.5) width: 1) ];
			connect: (aTag classes select: #isTrait)
			from: [ :aTrait | aTrait ]
			toAll: [ :aTrait | aTrait users asOrderedCollection ].

		aMondrian edges
			shape: [ :x | 
				BlLineElement new border:
						(BlBorder paint: (Color black alpha: 0.5) width: 1) ];
			connect: (aTag classes reject: #isTrait)
			from: [ :aTrait | aTrait ]
			toAll: [ :aTrait | aTrait subclasses asOrderedCollection ].

		aMondrian layout force
			strength: 0.15;
			charge: -250;
			length: 70 ].
	aMondrian
]

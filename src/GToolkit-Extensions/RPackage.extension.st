Extension { #name : #RPackage }

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtClassHierarchyFor: aView [
	<gtView>
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
	<gtView>
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
RPackage >> gtDependencyAnalyzerFor: aView [
	<gtPackageView>
	
	^ aView explicit
		title: 'Dependency Analysis';
		priority: 40;
		stencil: [ 
			| anAnalyzer anObjectHolder |
			anAnalyzer := GtDependencyAnalyzerEasy analyzePackageNamed: self name.
			anObjectHolder := GtInspectorObject new object: anAnalyzer; viewSelector: #gtPackageDependenciesFor:.
			GtInspector new objectHolder: anObjectHolder ];
		actionUpdateButtonTooltip: 'Update dependency analysis';
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect dependency analyzer' 
			action: [ :aButton | aButton phlow spawnObject: (GtDependencyAnalyzerEasy analyzePackageNamed: self name) ]
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtDependencyTreeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Dependencies';
		priority: 2;
		items: [ (self gtDependencies groupedBy: [ :each | each toPackage ])
				associations sorted: [ :a :b | a key name < b key name ] ];
		"children: [:each | (each gtPackagesUsed asOrderedCollection) copyWithout: each];
		"
		column: 'Package' text: [ :assoc | assoc key name ];
		column: 'Dependencies'
			text: [ :assoc | assoc value size ];
		send: #value
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtPackageDependentsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Package dependents';
		priority: 3;
		object: [ GtDependencyAnalyzerForPackage packageNamed: self name ];
		view: #gtPackageDependentsFor:
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtTagAndClassHierarchyFor: aView [
	<gtView>
	<gtPackageView>
	^ aView mondrian
		title: 'Tags Map';
		priority: 10.7;
		tooltip: 'Classes: black, Traits: orange';
		painting: [ :aMondrian | self paintTagAndClassHierarchyWith: aMondrian ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
RPackage >> gtTestsFor: aView [
	<gtView>
	<gtPackageView>
	| aMethodsCoder aTestSuiteViewModel anExampleViewModel |

	aMethodsCoder := (GtSearchPackageTestSuiteFilter new package: self) asCoder.

	aTestSuiteViewModel := GtPharoTestSuiteViewModel new methodsCoderModel: aMethodsCoder.
	anExampleViewModel := GtPharoExampleSuiteViewModel new methodsCoderModel: aMethodsCoder.

	^ aView explicit
		  title: 'Tests';
		  priority: 12;
		  stencil: [ aMethodsCoder ];
		  actionStencil: [ :aBrTab | 
			  GtPharoCoderUIUtility
				newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		  actionStencil: [ 
			  GtPharoCoderUIUtility
				  newTestsDropdownButtonForViewModel: aTestSuiteViewModel ]
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

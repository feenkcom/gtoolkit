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

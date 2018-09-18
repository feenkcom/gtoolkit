Extension { #name : #ConfigurationOf }

{ #category : #'*BaselineOfGToolkit' }
ConfigurationOf class >> gtMapFor: aView [
	<gtView>
	^ self 
		gtMapFor: aView 
		selectRelationsThat: [ :aBaselineA :aBaselineB | true ]
		nameDisplayedAs: [ :aRopedText | aRopedText ]
]

{ #category : #'*BaselineOfGToolkit' }
ConfigurationOf class >> gtMapFor: aView selectRelationsThat: aTwoArgBlock nameDisplayedAs: anOneArgBlock [
	^ aView mondrian
		title: 'Map';
		priority: 10;
		painting: [ :mondrian |
			| projects |
			projects := Set new.
			self project version 
				withDeep: [ :each | each projects collect: #version ]
				relationDo: [ :a :b | (aTwoArgBlock value: a value: b)
					ifTrue: [ projects add: a; add: b ] ].
			mondrian nodes 
				shape: [ :each | 
					| text element |
					text := [
						| displayString |
						displayString := (((each gtDisplayString 
							copyReplaceAll: 'BaselineOf' with: '')
							copyReplaceAll: 'ConfigurationOf' with: '')
							copyReplaceAll: 'GToolkit' with: 'GT ').
						(anOneArgBlock value: displayString) asRopedText ]
						on: Error do: [ :e | e asString asRopedText foreground: BrGlamorousColors linkWithErrorColor ].
					element := BlTextElement new.
					element 	
						text: text; 
						zIndex: 1; 
						when: BlClickEvent do: [ :e | e consumed: true. element fireEvent: (GtPhlowObjectToSpawn new object: each spec project configuration class; sourceElement: element) ] ];
				with: projects.
			mondrian edges
				shape: [ :each |
					BlParabollaArcElement new 
						zIndex: 0;
						curvatureFraction: 0.2;
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build))  ];
				fromRightCenter;
				toLeftCenter;
				connectFrom: #yourself 
				toAll: [:each | each projects collect: #version].
			mondrian layout custom: (GtGradHorizontalDominanceTreeLayout new levelDistance: 50; nodeDistance: 10)]
]

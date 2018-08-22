ui
gtMapFor: aView
	<gtView>
	^ aView mondrian
		title: 'Map';
		painting: [ :mondrian |
			| projects |
			projects := Set new.
			self project version 
				withDeep: [ :each | each projects collect: #version ]
				relationDo: [:a :b | 
					(a spec project configuration class name beginsWith: 'BaselineOfGToolkit') ifTrue: [ 
						projects add: a; add: b ] ].
			mondrian nodes 
				shape: [:each | 
					| text |
					text := [
						| displayString |
						displayString := (((each gtDisplayString 
							copyReplaceAll: 'BaselineOf' with: '')
							copyReplaceAll: 'ConfigurationOf' with: '')
							copyReplaceAll: 'GToolkit' with: 'GT ').
						displayString asRopedText
							foreground: ((displayString beginsWith: 'GT') ifTrue: [Color black] ifFalse: [Color gray]) ]
						on: Error do: [:e | e asString asRopedText foreground: Color red ].
					BlTextElement new text: text; zIndex: 1 ];
				with: projects.
			mondrian edges
				shape: [ :each |
					BlLineElement new 
						zIndex: 0;
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build))  ];
				fromNearestBounds;
				toNearestBounds;
				connectFrom: #yourself 
				toAll: [:each | each projects collect: #version].
			mondrian layout horizontalDominanceTree layered horizontalGap: 50; verticalGap: 30]
*GToolkit-Mondrian
gtInspectorMondrianMapIn: composite
	<gtInspectorPresentationOrder: 40>
	composite bloc
		title: 'Map (Bloc)';
		element: [ :bloc |
			| view |
			view := GtMondrian new. 
			view nodes
				umlClassShapeWithName: [ :each | each key name ];
				with: (self examples groupedBy: #methodClass) associations forEach: [ :assoc | 
				view nodes
					shape: [ :each |
						| text styler editor editorElement |
						BlElement new 	
							geometry: BlEllipse new;
							border: (BlBorder paint: Color black width: 2);
							size: 20@20;
							constraintsDo: [ :constraints |
								constraints padding: (BlInsets all: 10) ];
							 addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | bloc selection: each ]	];
					with: assoc value.
				view layout tree verticalGap: 100 ].
			view edges 
				fromCenterBottom;
				toCenterTop;
				shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 1) ];
				connect: self examples from: #yourself toAll: #directDependencies.
			view layout custom: GtGraphGridLayout new.
			view asScalableElement ]
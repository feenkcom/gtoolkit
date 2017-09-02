*GToolkit-Documenter
gtInspectorBlocGraphIn: composite
	<gtInspectorPresentationOrder: 40>
	composite bloc
		title: 'Graph (Bloc)';
		element: [ :bloc |
			| view |
			view := GtMondrian new. 
			view nodes 
				shape: [ :each | 
					BlElement new 
						geometry: BlEllipse new; 
						border: (BlBorder paint: Color black width: 2);	
						background: (BlBackground paint: (each = self ifTrue: [Color gray] ifFalse: [Color white]));
						addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | bloc selection: each ] ];
				with: (self withDeepCollect: #dependenciesOrArguments).
			view edges 
				fromCenterBottom; toCenterTop;
				connectToAll: #dependenciesOrArguments.
			view layout tree.
			view asScalableElement ]
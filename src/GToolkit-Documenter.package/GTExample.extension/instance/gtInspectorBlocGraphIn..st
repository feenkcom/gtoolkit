*GToolkit-Documenter
gtInspectorBlocGraphIn: composite
	<gtInspectorPresentationOrder: 40>
	composite blocMondrian
		title: '_Graph';
		painting: [ :view :x :presentation |
			view nodes 
				shape: [ :each | 
					BlElement new 
						geometry: BlEllipse new; 
						border: (BlBorder paint: Color black width: 1);	
						background: (BlBackground paint: (each = self ifTrue: [Color gray] ifFalse: [Color white]));
						size: 10@10;
						addEventHandlerOn: BlClickEvent do: [ :anEvent | presentation selection: each ] ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges 
				fromCenterBottom; toCenterTop;
				connectToAll: #directDependencies.
			view layout tree ]
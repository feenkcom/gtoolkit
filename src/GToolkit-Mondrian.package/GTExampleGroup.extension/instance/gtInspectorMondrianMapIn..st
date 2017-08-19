*GToolkit-Mondrian
gtInspectorMondrianMapIn: composite
	<gtInspectorPresentationOrder: 2>
	composite bloc
		title: 'Map';
		element: [ :bloc |
			| view |
			view := GtMondrian new. 
			view nodes: (self examples groupedBy: #methodClass) associations forEach: [ :assoc | 
				view shape: [ :each |
					BlElement new 	
						geometry: BlEllipse new;
						border: (BlBorder paint: Color black width: 2);
						size: 20@20;
						constraintsDo: [ :constraints |
							constraints padding: (BlInsets all: 10) ];
						 addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | bloc selection: each ]				
					 ].
				view nodes: assoc value.
				view layout: GtGraphRadialTreeLayout new ].
			"view shape line color: (Color black alpha: 0.5)."
			view shape: [ :each | 
				BlLineElement new
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 1)  ].
			view edges connect: self examples fromAll: #directDependents to: #yourself.
			view layout: GtGraphGridLayout new.
			view topStep root ]";
		send: [ :x | (x isKindOf: Association) ifTrue: [ self class new examples: x value ] ifFalse: [ x ] ]"
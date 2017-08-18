examples
elipseWithCustomShape
	<gtExample>
	| view |
	view := GtMondrian new.
	view shape: [ :anInteger | 
		BlElement new 	
			geometry: BlEllipse new;
			border: (BlBorder paint: Color black width: 2);
			size: (anInteger max: 5) asPoint;
			constraintsDo: [ :constraints |
				constraints padding: (BlInsets all: 10) ] ].
	view nodes: (1 to: 20).	
	view layout: (BlGraphCircleLayout new radius: 200).
	^ view
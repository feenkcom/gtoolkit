examples
elipseWithReusedShape
	<gtExample>
	| view |
	view := GtMondrian new.
	view shape: [ :anInteger :anElement | 
		anElement	
			geometry: BlEllipse new;
			size: (anInteger max: 5) asPoint;
			constraintsDo: [ :constraints |
				constraints padding: (BlInsets all: 10) ] ].
	view nodes: (1 to: 20).	
	view layout: (BlGraphCircleLayout new radius: 200).
	^ view
examples
elipseWithFactoryMethod
	<gtExample>
	| view |
	view := GtMondrian new.
	view ellipse: [ :anInteger :anEllipseElement | 
		anEllipseElement
			size: (anInteger max: 5) asPoint;
			constraintsDo: [ :constraints |
				constraints padding: (BlInsets all: 10) ] ].
	view nodes: (1 to: 20).
	view layout: (GtGraphCircleLayout new radius: 200).
	^ view 
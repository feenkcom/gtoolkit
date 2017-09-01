examples
elipseWithReusedShape
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :anInteger :anElement | 
			anElement
				geometry: BlEllipse new;
				size: (anInteger max: 5) asPoint;
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 20).
	view layout circle radius: 200.
	^ view
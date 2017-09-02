tutorial - shapes
nodesWithEllipses
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlElement new 
				border: (BlBorder paint: Color black);
				geometry: BlEllipse new; 
				size: (x * 2) @ (x * 2) ];
		with: (1 to: 9).
	^ view
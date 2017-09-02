tutorial - shapes
edgesWithThickerLines
	<gtExample>
	| view |
	view := self nodesWithEllipses.
	view edges
		shape: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
		connectFrom: [ :x | x // 2 ].
	view layout tree.
	^ view
tutorial - nesting
nestedWithEdges
	<gtExample>
	| view |
	view := self nestedNodes.
	view edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 2 ].
	view layout tree.
	^ view
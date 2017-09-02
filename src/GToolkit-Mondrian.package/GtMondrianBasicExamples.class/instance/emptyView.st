tutorial - nodes, edges, layouts
emptyView
	<gtExample>
	| view |
	view := GtMondrian new.
	self assert: view topStep root children isEmpty.
	^ view
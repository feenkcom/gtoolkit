tutorial - nodes, edges, layouts
twoNodes
	<gtExample>
	| view |
	view := self emptyView.
	view nodes with: {1 . 2}.
	self assert: view topStep root children size equals: 2.
	^ view
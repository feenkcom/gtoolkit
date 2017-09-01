node creation
oneNode
	<gtExample>
	| view |
	view := self emptyView.
	view nodes with: {1}.
	self assert: view topStep root children size equals: 1.
	^ view
examples
emptyView
	<gtExample>
	| view |
	view := GtMondrian new.
	self assert: view topStep root children isEmpty.
	^ view
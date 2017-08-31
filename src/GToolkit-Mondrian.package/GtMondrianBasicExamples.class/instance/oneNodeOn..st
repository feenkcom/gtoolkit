node creation
oneNodeOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes for: { 1 }.
	self assert: view topStep root children size equals: 1.
	^ view
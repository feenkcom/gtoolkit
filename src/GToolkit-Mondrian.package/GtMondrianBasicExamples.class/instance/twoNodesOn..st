node creation
twoNodesOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes with: {1 . 2}.
	self assert: view topStep root children size equals: 2.
	^ view
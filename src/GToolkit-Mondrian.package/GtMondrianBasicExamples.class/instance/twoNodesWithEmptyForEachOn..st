node creation
twoNodesWithEmptyForEachOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes: { 1 . 2 } forEach: [ :each | ].
	self assert: view topStep root children size equals: 2.
	^ view
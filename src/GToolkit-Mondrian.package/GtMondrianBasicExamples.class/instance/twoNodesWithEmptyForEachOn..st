node creation
twoNodesWithEmptyForEachOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes for: { 1 . 2 } forEach: [ :each | ].
	self assert: view topStep root children size equals: 2.
	^ view
node creation
twoNodesWithEmptyForEachOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes with: {1 . 2} forEach: [ :each |  ].
	self assert: view topStep root children size equals: 2.
	^ view
node creation
twoNodesWithNodesInForEachOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes: { { 1 . 2 . 3 } . { 4 } } forEach: [ :collection | view nodes: collection ].
	self assert: view topStep root children size equals: 2.
	self assert: view topStep root children first children size equals: 3.
	self assert: view topStep root children last children size equals: 1.
	self assert: view topStep root children last children first mondrianModel equals: 4.
	^ view
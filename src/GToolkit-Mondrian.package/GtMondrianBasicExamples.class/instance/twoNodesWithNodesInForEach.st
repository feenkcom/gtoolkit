node creation
twoNodesWithNodesInForEach
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		with:
			{{1 . 2 . 3}.
			{4}}
		forEach: [ :collection | view nodes with: collection ].
	self assert: view topStep root children size equals: 2.
	self assert: view topStep root children first children size equals: 3.
	self assert: view topStep root children last children size equals: 1.
	self
		assert: view topStep root children last children first mondrianModel
		equals: 4.
	^ view
edge creation
oneEdgeBetweenTwoNodesOn: view
	<gtExample>
	<dependsOn: #twoNodesOn:>
	view edges connect: { 1 . 2 } from: [ :x | x + 1 ] to: [ :x | x ].
	self assert: view topStep root mondrianEdgeChildren size equals: 1.
	^ view
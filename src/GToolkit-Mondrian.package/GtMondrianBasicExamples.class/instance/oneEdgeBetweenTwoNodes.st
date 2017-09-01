edge creation
oneEdgeBetweenTwoNodes
	<gtExample>
	| view |
	view := self twoNodes.
	view edges connect: { 1 . 2 } from: [ :x | x + 1 ] to: [ :x | x ].
	self assert: view topStep root mondrianEdgeChildren size equals: 1.
	^ view
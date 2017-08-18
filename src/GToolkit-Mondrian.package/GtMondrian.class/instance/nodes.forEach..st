scripting - core
nodes: aCollection forEach: aBlock
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self topStep nodeElementFor: each.
		self topStep addChild: child.
		self with: (GtMondrianStep new root: child) do: [ aBlock value: each ]. 
		child ].
	self topStep resetElement.
	^ elements
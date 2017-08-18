scripting - core
nodes: aCollection
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self topStep nodeElementFor: each.
		self topStep addChild: child.
		child ].
	self topStep resetElement.
	^ elements
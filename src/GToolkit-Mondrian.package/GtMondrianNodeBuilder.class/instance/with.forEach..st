instance creation
with: aCollection forEach: aBlock
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self nodeElementFor: each.
		self topStep addChild: child.
		self mondrian with: (GtMondrianStep new root: child) do: [ aBlock value: each ]. 
		child ].
	^ elements
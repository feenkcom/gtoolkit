scripting
with: aCollection
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self nodeElementFor: each.
		self topStep addChild: child.
		child ].
	createdElements addAll: elements.
	^ elements
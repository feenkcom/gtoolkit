scripting
with: aCollection
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self nodeElementFor: each.
		child ].
	self topStep addChildren: elements.
	createdElements addAll: elements.
	^ elements
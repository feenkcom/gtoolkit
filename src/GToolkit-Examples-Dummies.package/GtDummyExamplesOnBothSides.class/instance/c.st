examples
c
	<gtExample>
	| a b |
	a := self a.
	b := self b.
	self assert: a = 1.
	self assert: b = 2.
	^ a + b + 6
examples
d
	<gtExample>
	| classSideC |
	classSideC := self class classSideC.
	self assert: classSideC = 3.
	^ classSideC
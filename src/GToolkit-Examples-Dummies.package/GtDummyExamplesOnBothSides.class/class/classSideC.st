examples
classSideC
	<gtExample>
"	<dependsOn: #classSideA>
	<dependsOnClass: #'GTDummyExamplesOnBothSides class' selector: #classSideB:>
"	| a b |
	a := self classSideA.
	b := self classSideB.
	self assert: a = 2.
	self assert: b = 4.
	^ a + b - 3
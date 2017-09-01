examples
classSideB
	<gtExample>
	"<dependsOn: #classSideA>"
	| a |
	a := self classSideA.
	self assert: a = 2.
	^ a + 2
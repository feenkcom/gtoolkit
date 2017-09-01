examples
classSideD
	<gtExample>
	"<dependsOnClass: #GTDummyExamplesOnBothSides selector: #c:c:>"
	| instanceSideC |
	instanceSideC := self new c.
	self assert: instanceSideC = 9.
	^ instanceSideC
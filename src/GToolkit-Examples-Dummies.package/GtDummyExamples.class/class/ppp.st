examples
ppp
	<gtExample>
	<label: 'Dummy #ppp, depends #a, #b, #c'>
	<description: 'with description only'>
	"<dependsOn: #a>
	<dependsOn: #b:>
	<dependsOn: #c:>"
	| aBoolean1 aBoolean2 aBoolean3 |
	
	aBoolean1 := self a.
	aBoolean2 := self b.
	aBoolean3 := self c.
	
	self assert: (aBoolean1 | aBoolean2 | aBoolean3).
	^ aBoolean1 | aBoolean2 | aBoolean3
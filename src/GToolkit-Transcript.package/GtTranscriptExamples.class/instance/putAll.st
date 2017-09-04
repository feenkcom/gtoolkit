examples
putAll
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript next putAll: '42'.
	^ transcript
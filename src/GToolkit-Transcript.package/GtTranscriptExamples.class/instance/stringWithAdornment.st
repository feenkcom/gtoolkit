examples
stringWithAdornment
	<gtExample>
	| transcript |
	transcript := self transcript.
	transcript next
		expanding: [ BlElement new size: 70 @ 50; background: Color blue; yourself ]; 
		putAll: '42'.
	^ transcript
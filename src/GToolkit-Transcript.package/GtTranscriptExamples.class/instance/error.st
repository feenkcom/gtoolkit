examples
error
	<gtExample>
	| transcript |
	transcript := self transcript.
	[ 1/0 ] on: Error do: [ :err | 
		transcript next 
			putAll: 'Exception: ';
			showException: err ].
	^ transcript
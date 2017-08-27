examples
characterWithAdornmentOn: transcript
	<gtExample>
	<dependsOn: #transcript>
	transcript next
		expanding: [ BlElement new size: 70 @ 50; background: Color blue; yourself ]; 
		put: $4.
	transcript next put: $2.
	^ transcript
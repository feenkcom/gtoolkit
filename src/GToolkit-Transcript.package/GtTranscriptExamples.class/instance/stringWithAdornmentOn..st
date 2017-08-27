examples
stringWithAdornmentOn: transcript
	<gtExample>
	<dependsOn: #transcript>
	transcript next
		expanding: [ BlElement new size: 70 @ 50; background: Color blue; yourself ]; 
		putAll: '42'.
	^ transcript
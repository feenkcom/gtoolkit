examples
characterWithAdornmentOn: transcript
	<gtExample>
	<dependsOn: #transcript>
	transcript next
		with: [
			BrTextAdornmentDynamicAttribute new 	
				beAppend;
				elementBlock: [ BlElement new size: 70 @ 50; background: Color blue; yourself ] ]; 
		put: $4.
	transcript next put: $2.
	^ transcript
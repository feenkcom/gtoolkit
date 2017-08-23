examples
stringWithAdornmentOn: transcript
	<gtExample>
	<dependsOn: #transcript>
	transcript next
		with: [
			BrTextAdornmentDynamicAttribute new 	
				beAppend;
				elementBlock: [ BlElement new size: 70 @ 50; background: Color blue; yourself ] ]; 
		putAll: '42'.
	^ transcript
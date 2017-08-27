attributes
expanding: aBlock
	self attribute: (
		BrTextExpandButtonAttribute new 
			attributesCreatingBlock: [
				BrTextAdornmentDynamicAttribute new 	
					beAppend;
					elementBlock: aBlock ])

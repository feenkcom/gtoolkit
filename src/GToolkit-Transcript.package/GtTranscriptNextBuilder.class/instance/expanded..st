attributes
expanded: aBlock
	| adornmentAttribute |
	
	adornmentAttribute := BrTextAdornmentDynamicAttribute new 	
		beAppend;
		stencil: aBlock.
	
	self attributes: {
		BrTextExpandButtonAttribute new
			isExpanded: true;
			createdAttributes: { adornmentAttribute };
			attributesCreatingBlock: [
				BrTextAdornmentDynamicAttribute new 	
					beAppend;
					stencil: aBlock ] . 
		adornmentAttribute }
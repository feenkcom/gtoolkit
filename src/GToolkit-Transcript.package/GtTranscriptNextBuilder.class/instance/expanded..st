attributes
expanded: aBlock
	| adornmentAttribute |
	
	adornmentAttribute := BrTextAdornmentDynamicAttribute new 	
		beAppend;
		elementBlock: aBlock.
	
	self attributes: {
		BrTextExpandButtonAttribute new
			isExpanded: true;
			createdAttributes: { adornmentAttribute };
			attributesCreatingBlock: [
				BrTextAdornmentDynamicAttribute new 	
					beAppend;
					elementBlock: aBlock ] . 
		adornmentAttribute }
parsers
monospaceFormat
	^ super monospaceFormat token 
	==> [ :token | 
		self targetText 
			attributes: { BrFontGenericFamilyAttribute monospace .  BrTextForegroundAttribute paint: Color darkGray }
			from: token start
			to: token stop ]
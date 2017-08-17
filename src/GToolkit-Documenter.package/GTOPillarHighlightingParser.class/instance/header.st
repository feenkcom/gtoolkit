parsers
header
	^ super header token
	==> [ :t | 
		self targetText  
			attributes: { 
				BrFontSizeAttribute size: 20 - (t parsedValue first size)  }
			from: t start 
			to: t stop ]
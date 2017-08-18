parsers
annotatedParagraph
	^ super annotatedParagraph token
	==> [ :t | 
		self targetText 
					attributes: { BrTextForegroundAttribute paint: Color red muchDarker }
					from: t start 
					to: t stop. ]
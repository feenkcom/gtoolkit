parsers
figure
	^ super figure
		==> [ :tokens | 
			"make sure that file is a picture"
			"we are doing a horrible hack here: we are creating the preview by hand if it needs to be expanded"
			self handleFigureWithTokens: tokens ]
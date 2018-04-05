private-styles
styleExpandingCode
	self targetText
		attributes: self expandingAttributes
		from: self closingBracketsStartingPosition
		to: self closingBracketsEndPosition
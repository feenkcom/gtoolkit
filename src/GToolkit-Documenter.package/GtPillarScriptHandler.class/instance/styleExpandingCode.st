private-styles
styleExpandingCode
	self targetText
		attributes: self expandingAttributes
		from: tokens closingBracketsStartingPosition
		to: tokens closingBracketsEndPosition
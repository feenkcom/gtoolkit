private-styles
styleExecutableCode
	self targetText
		attributes: self executableCodeSnippetAttributes
		from: tokens closingBracketsEndPosition
		to: tokens closingBracketsEndPosition
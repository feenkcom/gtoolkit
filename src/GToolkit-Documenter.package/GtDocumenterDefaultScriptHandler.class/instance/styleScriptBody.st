private-styles
styleScriptBody
	| styler |
	styler := BrRBTextStyler new.
	styler
		style:
			(self targetText
				from: self scriptBodyStartingPosition
				to: self scriptBodyStopPosition).
	self targetText
		attributes:
			{BrFontGenericFamilyAttribute monospace.
			(BrFontSizeAttribute size: 14)}
		from: self scriptBodyStartingPosition
		to: self scriptBodyStopPosition
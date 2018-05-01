private-styles
styleScriptBody
	| styler document |
	styler := BrRBTextStyler new.
	document := GtDocument new.
	document addVariableBinding: #variableOne -> 42.
	self flag: 'debug code'.
	styler workspace: document.
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
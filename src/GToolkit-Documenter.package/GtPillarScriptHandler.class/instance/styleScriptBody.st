private-styles
styleScriptBody
	| styler strategy |
	styler := BrRBTextStyler new.
	codeSnippet ifNotNil: [ 
		strategy := GtHighlightingBindingStrategy bindings: codeSnippet.
		styler workspace: strategy ].
	styler
		style:
			(self targetText
				from: tokens scriptBodyStartingPosition
				to: tokens scriptBodyEndPosition).
	self targetText
		attributes:
			{BrFontGenericFamilyAttribute monospace.
			(BrFontSizeAttribute size: 14)}
		from: tokens scriptBodyStartingPosition
		to: tokens scriptBodyEndPosition
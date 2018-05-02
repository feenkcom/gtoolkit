private-styles
styleScriptBody
	| styler strategy |
	styler := BrRBTextStyler new.
	workspace ifNotNil: [ 
		strategy := GtHighlightingBindingStrategy bindings: workspace.
		styler workspace: strategy ].
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
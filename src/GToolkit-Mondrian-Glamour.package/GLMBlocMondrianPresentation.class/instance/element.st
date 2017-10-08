scripting
element
	| view |
	view := GtMondrian new. 
	paintingBlock glamourValue: 
			(view asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue,
			self asGlamorousMultiValue).
	^ view asScalableElement
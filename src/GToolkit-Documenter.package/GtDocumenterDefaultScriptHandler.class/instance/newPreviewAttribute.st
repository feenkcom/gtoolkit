instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ | composite |
			composite := BlElement new
				layout: BlLinearLayout new;
				padding: (BlInsets all: 5);
				border: (BlBorder paint: Color veryLightGray width: 1);
				constraintsDo: [ :c | 
					c textFlow pushLine.
					c vertical exact: 100.
					c horizontal matchParent ].
			(Compiler evaluate: self scriptBodyString)
				perform: self showParameterValue
				withArguments: {composite}.
			composite ]
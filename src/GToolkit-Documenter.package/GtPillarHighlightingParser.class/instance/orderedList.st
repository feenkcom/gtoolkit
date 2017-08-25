parsers
orderedList
	^ super orderedList
	==> [ :tokens | 
		tokens withIndexDo: [ :each :index |
			self targetText 
				attributes: {
					BrTextAdornmentDynamicAttribute new 
						beAppend; 
						elementBlock: [ 
							| indexText |
							indexText := BrRopedText string: index asString.
							indexText attributes: { BrFontSizeAttribute size: 9 . BrTextForegroundAttribute paint: Color lightGray }.
							BlTextElement new text: indexText ] }
				from: each start
				to: each stop ] ]
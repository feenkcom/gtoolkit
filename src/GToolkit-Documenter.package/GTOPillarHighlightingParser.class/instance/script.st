parsers
script
	| endParser |
	endParser := "newline asParser , "(EndMarkups at: PRScript) asParser token , space star , lineEnd ==> [:t | t first ].
	^ (Markups at: PRScript) asParser token , scriptParameters , endParser negate star token , endParser
	==> [ :t | 
		| styler |
		t second asDictionary 
			at: 'eg' 
			ifPresent: [ :example | [ 
				| exampleMethod |
				exampleMethod := Compiler evaluate: example.
				self targetText attributes: { 
					BrTextExpandButtonAttribute new attributesCreatingBlock: [ 
						BrTextAdornmentDynamicAttribute new beAppend; adornmentBlock: [	 
							| editorElement |
							editorElement := GTOExamplesStyler 
								editorElementOnSourceCode: exampleMethod sourceCode
								inClass: exampleMethod methodClass.
							editorElement margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10) ]] } 
					from: t last start
					to: t last stop.
				 ] on: Error do: [ :e | Transcript show: e] ]
			ifAbsent: [
				styler := BrRBTextStyler new.
				styler style: (self targetText from: t third start to: t third stop).
				self targetText 
					attributes: { 
					BrFontGenericFamilyAttribute monospace.
					BrFontSizeAttribute size: 14 }
					from: t third start
					to: t third stop ]
		]
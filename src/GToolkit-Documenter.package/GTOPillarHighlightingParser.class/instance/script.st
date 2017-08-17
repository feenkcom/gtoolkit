parsers
script
	| endParser |
	endParser := "newline asParser , "(EndMarkups at: PRScript) asParser token , space star , lineEnd ==> [:t | t first ].
	^ (Markups at: PRScript) asParser token , scriptParameters , endParser negate star token , endParser
	==> [ :t | 
		| styler |
		t second asDictionary 
			at: 'example' 
			ifPresent: [ :exampleString | 
				[ 
					| exampleMethod |
					exampleMethod := Compiler evaluate: exampleString.
					self targetText attributes: { 
						BrTextExpandButtonAttribute new attributesCreatingBlock: [ 
							BrTextAdornmentDynamicAttribute new beAppend; adornmentBlock: [	 
								t second inspect asDictionary 
									at: 'show'
									ifPresent: [ :selector | 
										(exampleMethod gtExample returnValue perform: selector asSymbol)
											margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10);
											border: (BlBorder paint: Color veryLightGray width: 1);
											constraintsDo: [ :c | 
												c textFlow pushLine.
												c horizontal matchParent.
												c vertical exact: 100  ] ]
									ifAbsent: [ 
										(GTOExamplesStyler 
											editorElementOnSourceCode: exampleMethod sourceCode
											inClass: exampleMethod methodClass)
											margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10) ] ] ] } 
						from: t last start
						to: t last stop.
				] 
					on: Error 
					do: [ :e | Transcript show: e] ]
			ifAbsent: [
				t third parsedValue notEmpty ifTrue: [
				styler := BrRBTextStyler new.
				styler style: (self targetText from: t third start to: t third stop).
				self targetText 
					attributes: { 
					BrFontGenericFamilyAttribute monospace.
					BrFontSizeAttribute size: 14 }
					from: t third start
					to: t third stop ] ]
		]
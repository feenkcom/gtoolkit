parsers
script
	| endParser |
	endParser := "newline asParser , "(EndMarkups at: PRScript) asParser token , space star , lineEnd ==> [:t | t first ].
	^ (Markups at: PRScript) asParser token , scriptParameters , endParser negate star token , endParser
	==> [ :aToken | 
		aToken second asDictionary 
			at: 'example' 
			ifPresent: [ :exampleString | 
				[ 
					| exampleMethod |
					exampleMethod := Compiler evaluate: exampleString.
					self targetText attributes: { 
						BrTextExpandButtonAttribute new attributesCreatingBlock: [ 
							BrTextAdornmentDynamicAttribute new beAppend; adornmentBlock: [	 
								aToken second asDictionary 
									at: 'show'
									ifPresent: [ :selector | 
										| exampleElement |
										exampleElement := GTOPillarExampleElement new.
										exampleElement
											margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10);
											constraintsDo: [ :c | 
												c textFlow pushLine.
												c horizontal matchParent.
												c vertical exact: 100  ].
										exampleElement example: exampleMethod gtExample.
										exampleElement previewShowBlock: selector asSymbol ]
									ifAbsent: [ 
										(GTOExamplesStyler 
											editorElementOnSourceCode: exampleMethod sourceCode
											inClass: exampleMethod methodClass)
											margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10) ] ] ] } 
						from: aToken last start
						to: aToken last stop.
				] 
				on: Error 
				do: [ :e | Transcript show: e] ]
			ifAbsent: [
				| styler |
				aToken third parsedValue notEmpty ifTrue: [
				styler := BrRBTextStyler new.
				styler style: (self targetText from: aToken third start to: aToken third stop).
				self targetText 
					attributes: { 
						BrFontGenericFamilyAttribute monospace.
						BrFontSizeAttribute size: 14 }
					from: aToken third start
					to: aToken third stop ] ]
		]
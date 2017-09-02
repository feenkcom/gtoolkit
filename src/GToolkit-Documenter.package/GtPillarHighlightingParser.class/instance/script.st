parsers
script
	| endParser |
	endParser := ((EndMarkups at: PRScript) asParser token , space star
		, lineEnd) ==> [ :t | t first ].	"newline asParser , "
	^ ((Markups at: PRScript) asParser token , scriptParameters
		, endParser negate star token , endParser)
		==> [ :tokens | 
			tokens second asDictionary
				at: 'example'
				ifPresent: [ :exampleString | self handleExampleFromString: exampleString withTokens: tokens ]
				ifAbsent: [ | styler |
					tokens third parsedValue notEmpty
						ifTrue: [ 
							styler := BrRBTextStyler new.
							styler style: (self targetText from: tokens third start to: tokens third stop).
							self targetText
								attributes: { 
									BrFontGenericFamilyAttribute monospace.
									(BrFontSizeAttribute size: 14)  }
								from: tokens third start
								to: tokens third stop.
							tokens second asDictionary 	
								at: 'show'
								ifPresent: [ :selector |
									| expandingAttribute |
									expandingAttribute := BrTextExpandButtonAttribute new
										attributesCreatingBlock: [
											BrTextAdornmentDynamicAttribute new
												beAppend;
												elementBlockWithErrorCatching: [ 
													| composite |
													composite := BlElement new
														layout: BlLinearLayout new;
														padding: (BlInsets all: 5);
														border: (BlBorder paint: Color veryLightGray width: 1);
														constraintsDo: [ :c |
															c textFlow pushLine.
															c vertical exact: 100.
															c horizontal matchParent ].
													(Compiler evaluate: tokens third parsedValue)
														perform: selector asSymbol
														withArguments: {composite}.
													composite ] ].
									self targetText
										attributes: { expandingAttribute }
										from: tokens fourth start
										to: tokens fourth stop.
								] ] ] ]
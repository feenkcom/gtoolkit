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
						ifTrue: [ styler := BrRBTextStyler new.
							styler
								style: (self targetText from: tokens third start to: tokens third stop).
							self targetText
								attributes:
									{BrFontGenericFamilyAttribute monospace.
									(BrFontSizeAttribute size: 14)}
								from: tokens third start
								to: tokens third stop ] ] ]
parsers
script
	| endParser |
	endParser := ((EndMarkups at: PRScript) asParser token , space star
		, lineEnd) ==> [ :t | t first ].	"newline asParser , "
	^ ((Markups at: PRScript) asParser token , scriptParameters
		, endParser negate star token , endParser)
		==>
			[ :tokens | self handleScriptWithTokens: tokens ]
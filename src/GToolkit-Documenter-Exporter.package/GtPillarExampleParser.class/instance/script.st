accessing
script
	| endParser startParser |
	endParser := ((EndMarkups at: PRCodeblock) asParser token, space star , lineEnd) 
		==> [ :t | t first ].
	startParser := (Markups at: PRCodeblock) asParser token, scriptParameters , endParser negate star token, endParser.
	^ startParser ==> [ :tokens | | scriptTokens scriptType |
		scriptTokens := GtPillarScriptTokens new.
		scriptTokens tokens: tokens.
		scriptType := GtPillarCodeSnippetDetector typeForScriptTokens: scriptTokens.
		scriptType parserHandlerClass 
			content: scriptTokens scriptBodyString 
			parameters: scriptTokens parameters ].
"		parameters := array second.
		parameters 
			at: 'example' 
			ifPresent: [ GtPillarExampleScript content: array third parameters: parameters ] 
			ifAbsent: [ PRCodeblock content: array third parameters: parameters ] ]
"	
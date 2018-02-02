accessing
script
	| endParser startParser |
	endParser := (EndMarkups at: PRScript) asParser , space star , lineEnd.
	startParser := (Markups at: PRScript) asParser , scriptParameters , endParser negate star flatten , endParser.
	^ startParser ==> [ :array | | parameters |
		parameters := array second.
		parameters 
			at: 'example' 
			ifPresent: [ GtPillarExampleScript content: array third parameters: parameters ] 
			ifAbsent: [ PRScript content: array third parameters: parameters ] ]
	
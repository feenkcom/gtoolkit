accessing
script
	| endParser startParser |
	endParser := (EndMarkups at: PRCodeblock) asParser , space star , lineEnd.
	startParser := (Markups at: PRCodeblock) asParser , scriptParameters , endParser negate star flatten , endParser.
	^ startParser ==> [ :array | | parameters |
		parameters := array second.
		parameters 
			at: 'example' 
			ifPresent: [ GtPillarExampleScript content: array third parameters: parameters ] 
			ifAbsent: [ PRCodeblock content: array third parameters: parameters ] ]
	
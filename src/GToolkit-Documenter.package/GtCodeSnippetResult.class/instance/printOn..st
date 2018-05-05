printing
printOn: aStream
	super printOn: aStream.
	index ifNil: [ ^ self ].
	aStream 
		nextPut: $[;
		print: index;
		nextPut: $].
	sourceCode ifNil: [ ^ self ].
	aStream nextPut: $[.
	aStream nextPutAll: (
		sourceCode lines 
			ifNotEmpty: [ :aCollection | aCollection first printStringLimitedTo: 10 ]
			ifEmpty: [ sourceCode ]).
	aStream nextPut: $].
	
	
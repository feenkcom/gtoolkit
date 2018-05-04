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
		sourceCode lines first printStringLimitedTo: 10).
	aStream nextPut: $].
	
	
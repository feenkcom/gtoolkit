scripting
connect: aCollection fromAll: aBlockOrSymbol 
	^ self 
		connect: aCollection
		fromAll: aBlockOrSymbol
		to: [ :x | x ]
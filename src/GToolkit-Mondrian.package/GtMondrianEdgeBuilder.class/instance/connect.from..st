scripting
connect: aCollection from: aBlockOrSymbol 
	^ self connect: aCollection from: aBlockOrSymbol to: [ :x | x ]
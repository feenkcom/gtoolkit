removing
removeAllAfterIndex: anInteger 
	self assert: [ anInteger isInteger ] description: [ 'Index should be an integer' ].
	self assert: [ anInteger > 0 and: [ anInteger <= collection size ] ] description: [ 'Index has to point to an existing item' ].
	collection removeLast: self size - anInteger.
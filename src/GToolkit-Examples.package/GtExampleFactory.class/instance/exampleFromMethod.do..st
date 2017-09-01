private
exampleFromMethod: aCompiledMethod do: aBlock
	self flag: 'Disable caching for now'.
	aBlock value: ("self cache exampleAt: aCompiledMethod ifAbsentPut: [ "self createExample: aCompiledMethod" ]")
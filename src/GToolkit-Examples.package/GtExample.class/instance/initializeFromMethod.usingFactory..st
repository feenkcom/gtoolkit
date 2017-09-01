initialization
initializeFromMethod: aCompiledMethod usingFactory: aGTExampleFactory
	methodClass := aCompiledMethod methodClass.
	selector := aCompiledMethod selector.
	aGTExampleFactory initializeExample: self fromMethod: aCompiledMethod
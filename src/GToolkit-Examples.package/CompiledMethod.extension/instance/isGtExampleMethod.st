*GToolkit-Examples-Core
isGtExampleMethod
	^ (self pragmas anySatisfy: [ :each | each isGTExamplePragma ])
		and: [ self numArgs = 0 ]
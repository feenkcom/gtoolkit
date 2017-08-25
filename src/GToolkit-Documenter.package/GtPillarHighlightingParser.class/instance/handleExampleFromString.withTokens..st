handling
handleExampleFromString: exampleString withTokens: aToken
	^ [ self doHandleExampleFromString: exampleString withTokens: aToken ]
		on: Error
		do: [ :e | Transcript show: e ]
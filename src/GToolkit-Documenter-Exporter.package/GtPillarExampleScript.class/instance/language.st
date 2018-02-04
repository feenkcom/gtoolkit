accessing-delegated
language
	super language
		isSpecified ifFalse: [ ^ PRSmalltalkScriptLanguage default ].
	^ super language
accessing-delegated
language
	super language
		isSpecified ifFalse: [ self language: PRSmalltalkScriptLanguage default ].
	^ super language
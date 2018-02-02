tests
testLanguageDefault
	instance := self classToTest new.
	self assert: instance language equals: PRSmalltalkScriptLanguage default
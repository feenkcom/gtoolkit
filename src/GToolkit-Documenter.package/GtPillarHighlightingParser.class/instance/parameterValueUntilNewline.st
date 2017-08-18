parsers
parameterValueUntilNewline
	"allow extra end markup"
	^ self parameterValueUntilParser: newline / (EndMarkups at: PRScript) asParser
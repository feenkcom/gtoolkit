accessing
parameterValueUntilNewline
	"allow extra end markup"
	^ (self parameterValueUntilParser: newline / (EndMarkups at: PRCodeblock) asParser)
		==> [ :array | self stringFrom: array ]
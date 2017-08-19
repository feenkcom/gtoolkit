accessing
lineItemsCount: aNumberOrASymbolOrABlock
	"The argument will be evaluated (using rtValue:) against the set of elements to perform the layout on. The result of this evaluation has to be a number, which indicates the number of elements per line"
	lineItemsCountBlock := aNumberOrASymbolOrABlock
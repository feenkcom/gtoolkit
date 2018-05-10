instance creation
newOutsInformationElement
	| anElement aText aModel |
	anElement := self newSlimButtonElement.
	aModel := BrButtonModel new.
	aText := ('(outs at: ' , codeSnippet index asString , ')')
		asRopedText.
	aText attributes: { 
		BrTextForegroundAttribute paint: Color gray.
		BrFontGenericFamilyAttribute monospace }.
	aModel label: aText.
	aModel action: [ self displayResult ].
	anElement viewModel: aModel.
	^ anElement
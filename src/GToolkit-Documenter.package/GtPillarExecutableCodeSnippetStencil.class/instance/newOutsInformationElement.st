instance creation
newOutsInformationElement
	| anElement aText aModel |
	anElement := self newSlimButtonElement.
	aModel := BrButtonModel new.
	aText := ('(outs at: ' , self codeSnippet index asString , ')')
		asRopedText.
	aText attributes: { 
		self codeSnippet isException
			ifTrue: [ BrTextForegroundAttribute paint: Color red ]
			ifFalse: [ BrTextForegroundAttribute paint: Color gray ].
		BrFontGenericFamilyAttribute monospace }.
	aModel label: aText.
	aModel action: [ self displayResult ].
	anElement viewModel: aModel.
	^ anElement
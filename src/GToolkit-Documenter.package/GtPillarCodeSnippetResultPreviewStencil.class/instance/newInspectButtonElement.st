instance creation
newInspectButtonElement
	| anElement aText aModel |
	anElement := self newSlimButtonElement.
	aModel := BrButtonModel new.
	aText := 'Inspect' asRopedText.
	aModel label: aText.
	aModel action: [ self displayResult ].
	anElement viewModel: aModel.
	^ anElement
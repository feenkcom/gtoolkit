instance creation
newInspectButtonElement
	| anElement aModel |
	
	aModel := BrButtonModel new.
	aModel label: 'Inspect'.
	aModel action: [ self displayResult ].
	
	anElement := self newSlimButtonElement.
	anElement viewModel: aModel.
	^ anElement
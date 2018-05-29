instance creation
newInspectButtonElement
	| anElement aModel |
	
	aModel := BrButtonModel new.
	"Stencils tend to be reusable, so we have to store a reference to the current result as a model of the view model"
	aModel model: self result.
	aModel label: 'Inspect'.
	aModel action: [ :aButtonElement :aButtonModel |
		aButtonElement fireEvent: (GLMBlocObjectToSelect new toSelect: aButtonModel model) ].
	
	anElement := self newSlimButtonElement.
	anElement viewModel: aModel.
	^ anElement
instance creation
newApplyChangesButtonElement
	<return: #BlElement>
	| aButton aModel |
	aButton := self newSlimButtonElement.
	aModel := self newApplyChangesButtonModel.
	aButton viewModel: aModel.
	^ aButton
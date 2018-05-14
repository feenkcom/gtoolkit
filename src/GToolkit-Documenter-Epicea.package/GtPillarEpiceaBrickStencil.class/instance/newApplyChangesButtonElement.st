instance creation
newApplyChangesButtonElement
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	aModel := self newApplyChangesButtonModel.
	aButton viewModel: aModel.
	^ aButton
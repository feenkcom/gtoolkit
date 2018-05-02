instance creation
newApplyChangesButtonElement
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	aModel := self newApplyChangesButtonModel.
	aLook := self newButtonLabelLook.
	aButton look: aLook.
	aButton viewModel: aModel.
	^ aButton
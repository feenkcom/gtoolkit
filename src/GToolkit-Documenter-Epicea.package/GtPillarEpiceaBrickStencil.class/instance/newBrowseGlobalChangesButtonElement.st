instance creation
newBrowseGlobalChangesButtonElement
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	aModel := self newBrowseGlobalChangesButtonModel.
	aLook := self newButtonLabelLook.
	aButton look: aLook.
	aButton viewModel: aModel.
	^ aButton
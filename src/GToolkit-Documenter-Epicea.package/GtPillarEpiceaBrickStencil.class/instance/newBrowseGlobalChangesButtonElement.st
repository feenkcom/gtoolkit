instance creation
newBrowseGlobalChangesButtonElement
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	aModel := self newBrowseGlobalChangesButtonModel.
	aButton viewModel: aModel.
	^ aButton
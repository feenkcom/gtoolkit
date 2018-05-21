instance creation
newBrowseGlobalChangesButtonElement
	<return: #BlElement>
	| aButton aModel |
	aButton := self newSlimButtonElement.
	aModel := self newBrowseGlobalChangesButtonModel.
	aButton viewModel: aModel.
	^ aButton
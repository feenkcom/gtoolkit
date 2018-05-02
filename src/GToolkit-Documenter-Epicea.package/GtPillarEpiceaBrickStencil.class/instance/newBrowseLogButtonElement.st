instance creation
newBrowseLogButtonElement
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	aModel := self newBrowseLogButtonModel.
	aLook := self newButtonLabelLook.
	aButton look: aLook.
	aButton viewModel: aModel.
	^ aButton
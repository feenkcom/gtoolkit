instance creation
newPlayButton
	<return: #BlElement>
	| aButton aModel |
	aButton := self newSlimIconifiedButtonElement.
	aModel := BrButtonModel new.
	aModel icon: self icon.
	aModel label: self label.
	aModel action: [ self executeCodeSnippet ].
	aButton viewModel: aModel.
	^ aButton
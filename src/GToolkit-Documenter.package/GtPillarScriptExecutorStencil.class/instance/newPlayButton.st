instance creation
newPlayButton
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	"aButton margin: (BlInsets left: 5)."
	aModel := BrButtonModel new.
	aModel icon: self icon.
	aModel label: self label.
	aModel action: [ self executeCodeSnippet ].
	"aLook := BrIconLook new + (BrLabelLook new fontSize: 12)."
	aLook := BrMaterialToggleIconifiedLook + BrMaterialToggleLabelledLook + GtPillarSlimButtonLook.
	aButton look: aLook.
	aButton viewModel: aModel.
	^ aButton
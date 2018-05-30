api - instantiation
create
	| aButton aLook |
	
	aLook := BrMaterialToggleIconifiedLook 
		+ BrMaterialToggleLabelledLook 
		+ GtPillarSlimButtonLook.

	aButton := BrButton new.
	aButton look: aLook.

	aButton icon: self icon.
	aButton label: self label.
	aButton action: self action.
	
	^ aButton
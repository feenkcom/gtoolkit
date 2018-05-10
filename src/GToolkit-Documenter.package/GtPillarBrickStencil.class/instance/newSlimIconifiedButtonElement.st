instance creation
newSlimIconifiedButtonElement
	<return: #BlElement>
	| aButton aLook |
	aButton := BlElement new.
	aLook := BrMaterialToggleIconifiedLook 
		+ BrMaterialToggleLabelledLook 
		+ GtPillarSlimButtonLook.
	aButton look: aLook.
	^ aButton
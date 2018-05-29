instance creation
newSlimButtonElement
	<return: #BlElement>
	| aButton aLook |

	aButton := BlElement new.
	aLook := BrMaterialToggleLabelledLook + GtPillarSlimButtonLook.
	aButton look: aLook.

	^ aButton
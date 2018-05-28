instance creation
newResizerBarElementOn: aResizableElement
	<return: #BlElement>
	
	^ BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aResizableElement)
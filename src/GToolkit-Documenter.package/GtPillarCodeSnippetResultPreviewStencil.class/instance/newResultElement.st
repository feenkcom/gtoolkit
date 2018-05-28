instance creation
newResultElement
	| aComposite aBarElement aResizerElement |
	aComposite := self newCompositeElement.
	aBarElement := self newLeftAlignedToolbarElement.
	aBarElement addChild: self newOutsInformationElement.
	aBarElement addChild: (BlElement new look: GtFlexibleHorizontalSpaceLook).
	aBarElement addChild: self newInspectButtonElement.
	aComposite addChild: aBarElement.
	aComposite addChild: self newInspectorElement.
	
	aResizerElement := self newResizerBarElement.
	aResizerElement addEventHandler: (BlResizerBottomListener new resizeTarget: aComposite).
	
	aComposite addChild: aResizerElement.
	
	^ aComposite 
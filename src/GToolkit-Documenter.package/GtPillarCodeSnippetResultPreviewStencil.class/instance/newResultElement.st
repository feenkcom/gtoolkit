instance creation
newResultElement
	| aComposite aBarElement |
	aComposite := self newCompositeElement.
	aBarElement := self newLeftAlignedToolbarElement.
	aBarElement addChild: self newOutsInformationElement.
	aBarElement addChild: (BlElement new look: GtFlexibleHorizontalSpaceLook).
	aBarElement addChild: self newInspectButtonElement.
	aComposite addChild: aBarElement.
	aComposite addChild: self newInspectorElement.
	^ aComposite 
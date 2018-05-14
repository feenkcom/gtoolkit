instance creation
newResultElement
	| aComposite aBarElement |
	aComposite := self newCompositeElement.
	aBarElement := self newLeftAlignedToolbarElement.
	aBarElement addChild: self newOutsInformationElement.
	aComposite addChild: aBarElement.
	aComposite addChild: self newInspectorElement.
	^ aComposite 
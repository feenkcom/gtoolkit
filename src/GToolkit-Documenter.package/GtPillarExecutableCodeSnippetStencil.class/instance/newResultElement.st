instance creation
newResultElement
	| aComposite aBarElement |
	aComposite := self newCompositeElement.
	aBarElement := self newBarElement.
	aBarElement addChild: self newOutsInformationElement.
	aBarElement addChild: self newPlayButton.
	aComposite addChild: aBarElement.
	aComposite addChild: self newInspectorElement.
	^ aComposite 
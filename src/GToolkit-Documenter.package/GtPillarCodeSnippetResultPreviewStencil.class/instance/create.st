instance creation
create
	"Return a preview element that is displayed in a document"
	<return: #BlElement>

	| aComposite aBarElement |

	aComposite := self newCompositeElement.
	
	aBarElement := self newLeftAlignedToolbarElement.
	aBarElement addChild: self newOutsInformationElement.
	aBarElement addChild: (BlElement new look: GtFlexibleHorizontalSpaceLook).
	aBarElement addChild: self newInspectButtonElement.
	
	aComposite addChild: aBarElement.
	aComposite addChild: self newInspectorElement.	
	aComposite addChild: (self newResizerBarElementOn: aComposite).
	
	^ aComposite 
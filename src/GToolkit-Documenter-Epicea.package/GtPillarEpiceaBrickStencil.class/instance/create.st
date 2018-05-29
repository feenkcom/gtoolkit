api - instantiation
create
	<return: #BlElement>
	| aTabGroup aDiffTab aResultTab aComposite aToolbar aResizerElement aFinalCodeElement |

	aComposite := self newCompositeElement.
	aComposite margin: (BlInsets top: 0 left: 20 bottom: 5 right: 20). 

	aToolbar := self newRightAlignedToolbarElement.
	aToolbar addChild: self newApplyChangesButtonElement.
	aToolbar addChild: self newBrowseGlobalChangesButtonElement.
	aComposite addChild: aToolbar.

	aDiffTab := BrTab new
		look: BrMaterialTabLabelledLook;
		label: 'Diff';
		stencil: [ self newDiffElement ].
	
	aResultTab := BrTab new
		look: BrMaterialTabLabelledLook;
		label: 'Code';
		stencil: [ aFinalCodeElement := self newFinalCodeElement constraintsDo: [ :c | c vertical matchParent ] ].
	
	aTabGroup := BrTabGroup new
		look: BrMaterialTabGroupLook;
		addTabs: { aResultTab . aDiffTab }.
	
	aComposite addChild: aTabGroup.
	
	aResizerElement := self newResizerBarElementOn: aComposite.
	aResizerElement
		when: BlDblClickEvent
		do: [ aFinalCodeElement ifNotNil: [
			aFinalCodeElement constraintsDo: [ :c | c vertical fitContent ].
			aComposite constraintsDo: [ :c | c vertical fitContent ] ] ].
	aResizerElement
		when: BlResizerResizedEvent
		do: [ aFinalCodeElement ifNotNil: [
			aFinalCodeElement constraintsDo: [ :c | c vertical matchParent ] ] ].

	aComposite addChild: aResizerElement.
	
	
	self codeSnippet epiceaLog hasImpact
		ifFalse: [ aTabGroup removeTab: aDiffTab ].
	self codeSnippet
		subscribe: GtEpiceaImpactChangedAnnouncement
		do: [ :anAnnouncement | 
			self
				handleEpiceaChangeImpact: anAnnouncement
				withGroup: aTabGroup
				diffTab: aDiffTab ].
	^ aComposite
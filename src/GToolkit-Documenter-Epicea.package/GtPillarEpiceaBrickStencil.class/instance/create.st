api - instantiation
create
	<return: #BlElement>
	| aTabGroup aDiffTab aResultTab aComposite aToolbar |
	aComposite := self newCompositeElement.
	aToolbar := self newRightAlignedToolbarElement.
	aToolbar addChild: self newApplyChangesButtonElement.
	aToolbar addChild: self newBrowseGlobalChangesButtonElement.
	aComposite addChild: aToolbar.
	aDiffTab := BrTabModel new
		label: 'Diff';
		content: [ self newDiffElement ].
	aResultTab := BrTabModel new
		label: 'Code';
		content: [ self newFinalCodeElement ].
	aTabGroup := BrTabGroupModel with: { aResultTab. aDiffTab }.
	aTabGroup tabs do: [ :aTab | 
		BlElement new
			look: BrMaterialTabLabelledLook;
			viewModel: aTab ].
	aComposite addChild: (BlElement new
		look: BrMaterialTabGroupLook;
		viewModel: aTabGroup).
	aComposite 
		margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20). 
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
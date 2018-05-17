instance creation
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
		content: [ self newEditorElement ].
	aResultTab := BrTabModel new
		label: 'Code';
		content: [ self newFinalCodeElement ].
	aTabGroup := BrTabGroupModel with: {aResultTab}.
	self codeSnippet epiceaLog hasImpact
		ifTrue: [ aTabGroup addTab: aDiffTab ].
	aTabGroup tabs
		do: [ :aTab | 
			BlElement new
				look: BrMaterialTabLabelledLook;
				viewModel: aTab ].
	aComposite
		addChild:
			(BlElement new
				look: BrMaterialTabGroupLook;
				viewModel: aTabGroup).
	self codeSnippet
		subscribe: GtEpiceaImpactChangedAnnouncement
		do: [ :anAnnouncement | 
			self
				handleEpiceaChangeImpact: anAnnouncement
				withGroup: aTabGroup
				diffTab: aDiffTab ].
	^ aComposite
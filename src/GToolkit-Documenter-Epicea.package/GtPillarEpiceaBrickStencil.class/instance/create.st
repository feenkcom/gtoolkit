instance creation
create
	<return: #BlElement>
	| tabGroup diffTab resultTab composite bar |
		
	composite := self newCompositeElement.
	bar := self newRightAlignedToolbarElement.
	bar addChild: self newApplyChangesButtonElement.
	bar addChild: self newBrowseGlobalChangesButtonElement.
	composite addChild: bar.
	diffTab := BrTabModel new
		label: 'Diff';
		content: [ self newEditorElement ].

	resultTab := BrTabModel new
		label: 'Code';
		content: [ self newFinalCodeElement ].

	tabGroup := BrTabGroupModel with: { resultTab . diffTab }.

	tabGroup tabs do: [ :aTab |
		BlElement new
			look: BrMaterialTabLabelledLook;
			viewModel: aTab ].

	composite addChild: (BlElement new
		look: BrMaterialTabGroupLook;
		viewModel: tabGroup).

	^ composite.
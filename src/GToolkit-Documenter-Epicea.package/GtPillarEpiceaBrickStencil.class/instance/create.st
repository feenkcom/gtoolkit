api - instantiation
create
	<return: #BlElement>
	| aTabGroup aDiffTab aResultTab aComposite aToolbar aResizerElement aFinalCodeElement |

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
		content: [ aFinalCodeElement := self newFinalCodeElement constraintsDo: [ :c | c vertical matchParent ] ].
	aTabGroup := BrTabGroupModel with: { aResultTab. aDiffTab }.
	aTabGroup tabs do: [ :aTab | 
		BlElement new
			look: BrMaterialTabLabelledLook;
			viewModel: aTab ].
	aComposite addChild: (BlElement new
		look: BrMaterialTabGroupLook;
		viewModel: aTabGroup).
	
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
	
	aComposite 
		margin: (BlInsets top: 0 left: 20 bottom: 5 right: 20). 
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
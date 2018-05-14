instance creation
create
	<return: #BlElement>
	| composite bar |
	composite := self newCompositeElement.
	bar := self newRightAlignedToolbarElement.
	bar addChild: self newApplyChangesButtonElement.
	bar addChild: self newBrowseGlobalChangesButtonElement.
	composite addChild: bar.
	composite addChild: self newEditorElement.
	^ composite.
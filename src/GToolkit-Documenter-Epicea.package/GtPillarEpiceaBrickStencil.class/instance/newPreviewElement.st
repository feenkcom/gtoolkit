instance creation
newPreviewElement
	<return: #BlElement>
	| composite bar |
	composite := self newCompositeElement.
	bar := self newBarElement.
	bar addChild: self newApplyChangesButtonElement.
	"bar addChild: self newBrowseLogButtonElement."
	bar addChild: self newBrowseGlobalChangesButtonElement.
	"bar addChild: self newRecordButtonElement." 
	composite addChild: bar.
	composite addChild: self newEditorElement.
	^ composite.
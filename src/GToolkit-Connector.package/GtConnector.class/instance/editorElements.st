search
editorElements
	"Return a collection of existing editor elements that are already added to the tree"
	<return: #SequenceableCollection of: #BrEditorElement>

	^ self children select: [ :anElement | anElement isKindOf: BrEditorElement ]
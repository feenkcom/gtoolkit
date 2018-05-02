instance creation
newEditorElement
	<return: #BrEditorElement>
	| editor editorElement |
	editor := BrTextEditor new.
	editor text: self ropeText.
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	editorElement look: GtPillarTextEditorLook new.
	^ editorElement
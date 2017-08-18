ui
newEditorElement
	| editorElement |
	editorElement := BrEditorElement new
		editor: editor;
		yourself.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	editorElement addEventHandler: BrTextEditorSelectionHandler new.
	^ editorElement
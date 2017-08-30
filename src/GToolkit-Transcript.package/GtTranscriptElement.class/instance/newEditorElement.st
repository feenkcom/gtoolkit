instance creation
newEditorElement
	^ BrEditorElement new
		addEventHandler: BrTextEditorSelectionHandler new;
		yourself
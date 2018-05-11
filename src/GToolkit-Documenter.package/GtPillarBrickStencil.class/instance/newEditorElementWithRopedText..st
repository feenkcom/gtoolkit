instance creation
newEditorElementWithRopedText: aRopedText
	<return: #BrEditorElement>
	| anEditor anEditorElement |
	anEditor := BrTextEditor new.
	anEditor text: aRopedText.
	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditor.
	anEditorElement look: GtPillarTextEditorLook new.
	^ anEditorElement
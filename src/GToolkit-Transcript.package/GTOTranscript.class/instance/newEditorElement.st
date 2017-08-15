ui
newEditorElement
	| editorElement |
	editorElement := BrEditorElement new
		size: 300@500;
		editor: editor;
		yourself.
	editorElement editor segmentBuilder: (BrTextEditorAttributedLineSegmentBuilder new).
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	editorElement addEventHandler: BrTextEditorSelectionHandler new.
	^ editorElement
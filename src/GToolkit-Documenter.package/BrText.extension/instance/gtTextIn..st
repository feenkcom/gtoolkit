*GToolkit-Documenter
gtTextIn: anElement
	| editorElement |
	editorElement := BrEditorElement new editor: (BrTextEditor new text: self).
	editorElement constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ].
	anElement addChild: editorElement
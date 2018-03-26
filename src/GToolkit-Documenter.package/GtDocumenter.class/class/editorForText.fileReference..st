opening
editorForText: aString fileReference: aFileReference
	| text styler editor editorElement |

	text := aString asRopedText.
	styler := GtPillarStyler new fileReference: aFileReference.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement padding: (BlInsets all: 10).
	editorElement constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	editorElement editor: editor.

	^ GtPillarEditorElement new
		editorElement: editorElement;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
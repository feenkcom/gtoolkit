opening
editorForPillar: aPillarFile
	| text styler editor editorElement fileReference |
	fileReference := aPillarFile asFileReference.
	
	text := BrRopedText string: fileReference contents.
	styler := GtPillarStyler new fileReference: fileReference.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	editorElement editor: editor.
	
	^ GtPillarEditorElement new
		editorElement: editorElement;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
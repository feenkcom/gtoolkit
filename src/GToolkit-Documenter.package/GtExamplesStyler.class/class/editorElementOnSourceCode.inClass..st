as yet unclassified
editorElementOnSourceCode: aString inClass: aClass
	| styler editor editorElement text |
	
	text := BrRopedText string: aString.
	
	styler := GtExamplesStyler new.
	styler classOrMetaClass: aClass.
	
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	
	editorElement
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ];
		background: Color white;
		border: (BlBorder paint: Color veryLightGray width: 1).
	^ editorElement
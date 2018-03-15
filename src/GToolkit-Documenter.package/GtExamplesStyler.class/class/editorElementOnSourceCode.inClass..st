factory
editorElementOnSourceCode: aString inClass: aClass
	| styler editor editorElement text |
	
	text := BrRopedText string: aString.
	styler := self new.
	styler classOrMetaClass: aClass.
	text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler . (BrFontSizeAttribute new size: 14) beNotOverwritableByStyler}.
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
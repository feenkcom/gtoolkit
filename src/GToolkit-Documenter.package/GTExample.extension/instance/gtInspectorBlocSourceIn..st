*GToolkit-Documenter
gtInspectorBlocSourceIn: composite
	<gtInspectorPresentationOrder: 40>
	composite bloc
		title: '_Source';
		element: [ 
			| text styler editor editorElement |
			text := BrRopedText string: self method sourceCode.
			text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler}.
			styler := GtExamplesStyler new classOrMetaClass: self methodClass.
			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.
			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
			    c horizontal matchParent.
			    c vertical matchParent ].
			editorElement editor: editor ]
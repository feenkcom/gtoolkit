private
extraStyle: aText ast: ast
	super style: aText ast: ast.
	(ast pragmas anySatisfy: [ :each | each selector = #gtExample ]) ifTrue: [ 
		ast pragmas do: [ :each |
			each selector = #dependsOn: ifTrue: [ 
				aText 
					attributes: { BrTextExpandButtonAttribute new attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new beAppend; adornmentBlock: [	 
						| newText styler editor editorElement |
						newText := BrRopedText string: (ast methodNode methodClass >> each arguments anyOne value) sourceCode.
						styler := GTOExamplesStyler new.
						styler classOrMetaClass: ast methodNode methodClass.
						editor := BrTextEditor new.
						editor segmentBuilder: BrTextEditorAttributedLineSegmentBuilder new.
						editor styler: styler.
						editor text: newText.
						editorElement := BrEditorElement new.
						editorElement constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical matchParent ].
						editorElement editor: editor.
						editorElement
							constraintsDo: [ :c | 
								c textFlow pushLine.
								c vertical fitContent ];
						size: 500 @ 100;
						background: Color white;
						border: (BlBorder paint: Color veryLightGray width: 1);
						yourself ]] } 
					from: each left
					to: each right.
				Transcript 
					show: ast methodNode methodClass name] ] 
	]
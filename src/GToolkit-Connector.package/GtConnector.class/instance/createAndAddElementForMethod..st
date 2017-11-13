private
createAndAddElementForMethod: method
	| editor editorElement text |
	text := BrRopedText string: method sourceCode.
	styler := GtExamplesSpawnStyler new
		exampleAction: [ :exampleMethod :messageNode :button | 
			self addMethod: exampleMethod.
			self connectButton: button ];
		classOrMetaClass: method methodClass.
	editor := BrTextEditor new styler: styler; text: text.
	styler
		when: GtConnectorButtonsChangedByStyler
		do: [ :event | 
			editor
				dispatchEvent:
					(GtConnectorButtonsChangedInEditor new
						newButtons: event newButtons;
						oldButtons: event oldButtons;
						editor: editor) ].
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	editorElement editor: editor.
	editorElement userData at: #editedMethod put: method.
	editor
		when: GtConnectorButtonsChangedInEditor
		do: [ :event | 
			editorElement
				dispatchEvent:
					(GtConnectorButtonsChangedInElement new
						newButtons: event newButtons;
						oldButtons: event oldButtons;
						element: editorElement) ].
	self addChild: editorElement.
	^ editorElement
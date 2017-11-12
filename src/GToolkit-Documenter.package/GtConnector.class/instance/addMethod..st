children hooks
addMethod: method
	| text editor editorElement |
	text := BrRopedText string: method sourceCode.
	styler := GtExamplesSpawnStyler new 
		exampleAction: [ :exampleMethod :messageNode :button | self addMethod: exampleMethod ];
		classOrMetaClass: method methodClass.
	editor := BrTextEditor new.
	editor styler: styler.
	styler 
		when: GtConnectorButtonsChangedByStyler 
		do: [ :event | 
			editor dispatchEvent: (GtConnectorButtonsChangedInEditor new newButtons: event newButtons; oldButtons: event oldButtons; editor: editor) ]. 
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement constraintsDo: [ :c |
	    c horizontal fitContent.
	    c vertical fitContent ].
	editorElement editor: editor.
	editorElement userData at: #editedMethod put: method.
	editor 
		when: GtConnectorButtonsChangedInEditor 
		do: [ :event | 
			editorElement dispatchEvent: (GtConnectorButtonsChangedInElement new newButtons: event newButtons; oldButtons: event oldButtons; element: editorElement) ].
	self addChild: editorElement.
	editorElement 
		when: GtConnectorButtonsChangedInElement 
		do: [:event | 
			self connectButtons: event newButtons.
			self removeConnectionsFromButtons: event oldButtons ]
	
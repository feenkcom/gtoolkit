accessing
transcript: aGtTranscript
	transcript := aGtTranscript.
	
	editorElement editor: transcript editor.

	transcript editor
		addEventFilterOn: BrTextEditorInsertedEvent
		do: [ self updateScroll ].

	self updateScroll
public
addMethod: method
	| editorElement |
	self elementWithMethod: method ifPresent: [ :element | ^ element ].
	editorElement := self createAndAddElementForMethod: method.
	editorElement
		when: GtConnectorButtonsChangedInElement
		do: [ :event | 
			self removeConnectionsFromButtons: event oldButtons.
			event newButtons do: [ :newButton | self connectButton: newButton ] ]
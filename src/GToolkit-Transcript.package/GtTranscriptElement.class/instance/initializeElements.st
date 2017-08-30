initialization
initializeElements
	editorElement := self newEditorElement.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	scrollButtonElement := self newScrollButtonElement.
	scrollButtonElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c padding: (BlInsets all: 10) ].
	self updateScrollButton.
	
	self addChildren: { editorElement . scrollButtonElement }
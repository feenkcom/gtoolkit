instance creation
newEditorElement
	<return: #BrEditorElement>
	| editorElement |
	editorElement := self newEditorElementWithRopedText: self diffRope.
	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			editorElement editor text: self diffRope ].
	^ editorElement
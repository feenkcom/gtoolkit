instance creation
newDiffElement
	<return: #BrEditorElement>
	| diffElement |
	diffElement := self newEditorElementWithRopedText: self diffRope.
	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			diffElement editor text: self diffRope ].
	^ diffElement
instance creation
newDiffElement
	<return: #BrEditorElement>
	| diffElement |
	diffElement := self newEditorElementWithRopedText: self diffRope.
	diffElement background: (Color r: 0.95 g: 0.95 b: 0.95).
	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			diffElement editor text: self diffRope ].
	^ diffElement
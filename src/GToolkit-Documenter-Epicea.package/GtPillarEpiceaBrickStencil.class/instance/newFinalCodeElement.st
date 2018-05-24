instance creation
newFinalCodeElement
	<return: #BrEditorElement>
	| editorElement |
	editorElement := self newEditorElementWithRopedText: self finalCodeRope.
	editorElement background: (Color r: 0.95 g: 0.95 b: 0.95).
"	styler := BrRBTextStyler new.
	editorElement editor styler: styler.
"	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			editorElement editor text: self finalCodeRope ].
	^ editorElement
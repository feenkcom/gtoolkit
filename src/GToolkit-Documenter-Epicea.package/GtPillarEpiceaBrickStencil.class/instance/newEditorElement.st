instance creation
newEditorElement
	<return: #BrEditorElement>
	| editorElement |
	editorElement := self newEditorElementWithRopedText: self diffRope.
	self epiceaLog onImpactChangedDo: [ :anAnnouncement | 
		editorElement editor text: self diffRope ].
	^ editorElement
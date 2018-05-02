instance creation
newEditorElement
	<return: #BrEditorElement>
	| editorElement |
	editorElement := super newEditorElement.
	epiceaLog onImpactChangedDo: [ :anAnnouncement | 
		editorElement editor text: self diffRope ].
	^ editorElement
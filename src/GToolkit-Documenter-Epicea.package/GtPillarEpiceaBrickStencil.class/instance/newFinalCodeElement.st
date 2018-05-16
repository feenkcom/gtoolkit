instance creation
newFinalCodeElement
	<return: #BrEditorElement>
	| editorElement |
	editorElement := self newEditorElementWithRopedText: self finalCodeRope.
	self epiceaLog onImpactChangedDo: [ :anAnnouncement | 
		editorElement editor text: self finalCodeRope ].
	^ editorElement
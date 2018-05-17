instance creation
newFinalCodeElement
	<return: #BrEditorElement>
	| editorElement styler |
	editorElement := self newEditorElementWithRopedText: self finalCodeRope.
	styler := BrRBTextStyler new.
	editorElement editor styler: styler.
	self epiceaLog onImpactChangedDo: [ :anAnnouncement | 
		editorElement editor text: self finalCodeRope ].
	^ editorElement
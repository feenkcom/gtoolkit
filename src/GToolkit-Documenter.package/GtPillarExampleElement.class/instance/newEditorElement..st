instance creation
newEditorElement: aGTExample
	"Instantiate a new editor for a given GT-Example"
	<return: #BrEditorElement>
	
	^ GtExamplesStyler 
		editorElementOnSourceCode: aGTExample methodSourceCode
		inClass: aGTExample methodClass
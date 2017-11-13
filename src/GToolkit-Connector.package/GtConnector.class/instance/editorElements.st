search
editorElements 
	^ self children select: [ :each | (each isKindOf: BrEditorElement) ]
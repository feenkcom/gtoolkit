*GToolkit-Documenter
gtTextIn: anElement
	| editorElement |

	editorElement := BrEditorElement new editor: (BrTextEditor new text: self text copy).
	editorElement constraintsDo: [ :c | 
		c vertical matchParent. 
		c horizontal matchParent.		
		c padding: (BlInsets all: 10) ].
	anElement addChild: (GtPillarEditorElement new
		editorElement: editorElement;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ])
*GToolkit-Documenter
gtLiveIn: anElement
	anElement addChild: (BrEditorElement new 
		editor: self;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent. ])
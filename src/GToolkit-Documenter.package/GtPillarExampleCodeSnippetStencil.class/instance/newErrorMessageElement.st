instance creation
newErrorMessageElement
	<return: #BlElement>
	^ self newCompositeElement 
		addChild: (self newEditorElementWithRopedText: self errorMessageRopedText)
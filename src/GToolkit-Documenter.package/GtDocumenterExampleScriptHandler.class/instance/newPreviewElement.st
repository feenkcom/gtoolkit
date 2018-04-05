instance creation
newPreviewElement
	<return: #BlElement>
	^ self hasShowParameter
		ifTrue: [ self newPreviewElementFromShowParameter ]
		ifFalse: [ self newPreviewEditorElement ]
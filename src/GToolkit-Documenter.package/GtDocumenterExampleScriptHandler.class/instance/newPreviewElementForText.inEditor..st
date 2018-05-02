instance creation
newPreviewElementForText: aBrText inEditor: aTextElement
	<return: #BlElement>
	^ self hasShowParameter
		ifTrue: [ self newPreviewElementFromShowParameter ]
		ifFalse: [ self newPreviewEditorElement ]
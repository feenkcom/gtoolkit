instance creation
newPreviewElementForText: aBrText inEditor: aTextElement
	<return: #BlElement>
	^ tokens hasShowParameter
		ifTrue: [ self newPreviewElementFromShowParameter ]
		ifFalse: [ self newPreviewEditorElement ]
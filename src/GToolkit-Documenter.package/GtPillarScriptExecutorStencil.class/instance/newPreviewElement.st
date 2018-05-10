instance creation
newPreviewElement
	"Return a preview element that is displayed in a document"

	<return: #BlElement>
	^ self codeSnippet hasResult 
		ifTrue: [ self newResultElement ]
		ifFalse: [ self newInlinedButtons ]
instance creation
newPreviewElementForText: aBrText inEditor: aTextElement
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>
	| aPreviewStencil |

	aPreviewStencil := (self previewStencilBuilder
		text: aBrText;
		editor: aTextElement;
		codeSnippet: codeSnippet) build.

	^ aPreviewStencil asElement
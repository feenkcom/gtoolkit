*GToolkit-Documenter
gtPrintIn: anElement
	| textElement |
	textElement := BlTextElement new text: self printString asRopedText.
	anElement addChild: textElement.
	^ textElement
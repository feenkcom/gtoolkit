streaming
nextPutAll: aString with: aBlock
	| previewAttribute |

	editor insertString: aString asString at: text size.
	editor moveCursorTo: text size.
	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: aBlock.
	text 
		attributes: { previewAttribute }
		from: text size - aString size + 1
		to: text size
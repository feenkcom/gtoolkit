streaming
nextPutAll: aString
	editor insertString: aString asString at: text size.
	editor moveCursorTo: text size.
	text
		clearAttributes: text size - aString size + 1
		to: text size
		if: [ :anAttribute | anAttribute isKindOf: BrTextExpandButtonAttribute ]
streaming
nextPutAll: aString
	editor insertString: aString asString at: text size.
	editor moveCursorTo: text size
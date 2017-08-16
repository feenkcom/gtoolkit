streaming
nextPut: aCharacter
	editor insertString: aCharacter asString at: text size.
	editor moveCursorTo: text size
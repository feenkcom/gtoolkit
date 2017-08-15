streaming
nextPutAll: aString
	aString do: [ :character | 
		self flag: 'change this once the editor is able to insert whole strings'.
		editor insertString: character asString at: text size ].
	editor moveCursorTo: text size.
	editor invalidateAll; updateAll
streaming
nextPutAll: aString with: aBlock
	| previewAttribute |
	aString do: [ :character | 
		self flag: 'change this once the editor is able to insert whole strings'.
		editor insertString: character asString at: text size ].
	editor moveCursorTo: text size.
	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: aBlock.
	text 
		attributes: { previewAttribute }
		from: text size - aString size + 1
		to: text size.
	editor invalidateAll; updateAll
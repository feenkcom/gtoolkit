streaming
putAll: aString
	transcript editor insertString: aString asString at: transcript text size.
	transcript editor moveCursorTo: transcript text size.
	transcript text
		clearAttributes: transcript text size - aString size + 1
		to: transcript text size
		if: [ :anAttribute | anAttribute isKindOf: BrTextExpandButtonAttribute ].
	adornmentStrategy executeOn: aString for: self transcript
streaming
putAll: aString
	transcript editor insertString: aString asString at: transcript text size.
	transcript editor moveCursorTo: transcript text size.
	"we delete the possible attributes inherited from the previously existing text"
	transcript text
		clearAttributes: transcript text size - aString size + 1
		to: transcript text size
		if: [ :a | true ].
	"apply the possible adornment"
	adornmentStrategy executeOn: aString for: self transcript
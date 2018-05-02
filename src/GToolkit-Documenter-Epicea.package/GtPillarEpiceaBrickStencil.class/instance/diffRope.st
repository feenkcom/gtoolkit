accessing - parameters
diffRope
	<return: #BrRopedText>
	| builder text |
	builder := PrettyTextDiffBuilder from: epiceaLog currentStateString to: epiceaLog newStateString.
	text := '' asRopedText.
	builder
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '  ' at: text size.
			text insertString: string at: text size.
			text 
				attributes: { BrTextForegroundAttribute paint: Color black } 
				from: initialPosition to: text size.
			text insertString: String cr at: text size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '+ ' at: text size.
			text insertString: string at: text size.
			text 
				attributes: { BrTextForegroundAttribute paint: Color green muchDarker } 
				from: initialPosition to: text size.
			text insertString: String cr at: text size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '- ' at: text size.
			text insertString: string at: text size.
			text 
				attributes: { BrTextForegroundAttribute paint: Color red muchDarker } 
				from: initialPosition to: text size.
			text insertString: String cr at: text size. ].
	text isEmpty ifFalse: [ 
		text attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ text
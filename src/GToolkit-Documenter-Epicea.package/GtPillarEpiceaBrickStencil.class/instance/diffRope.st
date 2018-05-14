accessing - parameters
diffRope
	<return: #BrRopedText>
	| aBuilder aRopedText |
	aBuilder := PrettyTextDiffBuilder 
		from: self epiceaLog currentStateString 
		to: self epiceaLog newStateString.
	aRopedText := '' asRopedText.
	aBuilder
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '  ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			aRopedText 
				attributes: { BrTextForegroundAttribute paint: Color black } 
				from: initialPosition to: aRopedText size.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '+ ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			aRopedText 
				attributes: { BrTextForegroundAttribute paint: Color green muchDarker } 
				from: initialPosition to: aRopedText size.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '- ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			aRopedText 
				attributes: { BrTextForegroundAttribute paint: Color red muchDarker } 
				from: initialPosition to: aRopedText size.
			aRopedText insertString: String cr at: aRopedText size. ].
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ aRopedText
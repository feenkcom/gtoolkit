accessing
centered
	align := #center.
	translateElement := [ :aTranslator :anElement :newPos | translator translateCenterLeftOf: anElement to: newPos ].
	
	self inCellPosition: [ :cell | cell extent x @ 0 ]

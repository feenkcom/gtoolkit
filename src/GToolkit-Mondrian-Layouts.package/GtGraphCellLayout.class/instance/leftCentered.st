accessing
leftCentered
	align := #left.

	translateElement := [ :aTranslator :anElement :newPos | translator translateTopLeftOf: anElement to: newPos ].
	
	"self inCellPosition: [ :cell | 0 @ ((cell extent y - cell element height) / 2) ]"
	self inCellPosition: [ :cell | cell extent x @ 0 ]

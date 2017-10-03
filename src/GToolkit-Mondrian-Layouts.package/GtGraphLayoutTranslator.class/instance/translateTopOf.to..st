public - translating
translateTopOf: element to: newPosition
	"Translate the top side of the element"

	self translate: element to: element measuredBounds position x @ newPosition direction: 0 @ 1.
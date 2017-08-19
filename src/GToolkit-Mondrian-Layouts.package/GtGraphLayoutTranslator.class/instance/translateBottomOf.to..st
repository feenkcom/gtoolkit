public - translating
translateBottomOf: element to: newPosition
	"Translate the bottom side of the element"

	self translate: element to: element position x @ newPosition direction: 0 @ -1
public - translating
translateRightOf: element to: newPosition
	"Translate the right side of the element"

	self translate: element to: newPosition @ element measuredBounds position y direction: -1 @ 0.
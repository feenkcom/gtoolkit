public - translating
translateRightOf: element to: newPosition
	"Translate the right side of the element"

	self translate: element to: newPosition @ element position y direction: -1 @ 0.
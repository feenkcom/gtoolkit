public - translating
translateLeftOf: element to: newPosition
	"Translate the left side of the element"

	self translate: element to: newPosition @ element position y direction: 1 @ 0.
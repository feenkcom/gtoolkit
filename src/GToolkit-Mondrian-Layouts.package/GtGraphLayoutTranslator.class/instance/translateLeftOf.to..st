public - translating
translateLeftOf: element to: newPosition
	"Translate the left side of the element"

	self translate: element to: newPosition @ element measuredBounds position y direction: 1 @ 0.
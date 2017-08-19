public - translating
translate: element to: newPosition direction: aDirection
	"Translate the bottom left corner of the element"

	self translate: element to: newPosition" + (element extent / 2 * aDirection)"
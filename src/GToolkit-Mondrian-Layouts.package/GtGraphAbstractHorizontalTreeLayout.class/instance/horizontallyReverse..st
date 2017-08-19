reversing
horizontallyReverse: elements
	"Horizontally reverse the elements, as well as the attachpoints"

	super horizontallyReverse: elements.
	self inverseAttachPointIfNecessary
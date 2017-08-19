reversing
verticallyReverse: elements
	"Vertically reverse the elements, as well as the attachpoints"

	super verticallyReverse: elements.
	self inverseAttachPointIfNecessary
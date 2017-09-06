accessing
root: anElement
	"The root is a Bloc element that is marked as children container.
	It is not necessarily a Mondrian node"
	root := anElement.
	root layout: GtGraphGridLayout new
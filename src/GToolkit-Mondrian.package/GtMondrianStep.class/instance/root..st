accessing
root: anElement
	"Setting the root element essentially contains the Mondrian shape.
	At this stage we also can already gather the element that can contain children."
	root := anElement.
	childrenContainer := root.
	root allChildrenBreadthFirstDo: [ :each | 
		each isMondrianChildrenContainer ifTrue: [ 
			childrenContainer := each ] ].
	self layout: GtGraphGridLayout new
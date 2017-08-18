*GToolkit-Mondrian
isMondrianChildrenContainer
	"this property marks an element for being a container of children within the Mondrian context.
	it is useful in the following Mondrian context:
		1. the developer first describes the shape of a node
		2. and then adds children to the node.
	when adding the shape, which is can be a complicated element, the developer can mark the sub-element
	that can contain children, and this information will be taken into account when adding
	the children to the node."
	^ self userData at: #isMondrianChildrenContainer ifAbsent: [ false ]
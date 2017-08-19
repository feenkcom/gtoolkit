public
on: elements edges: edges
	"Do the layout of the elements tacking into account the provided edges"

	^ self new 
		userDefinedEdges: edges;
		applyOn: elements.
actions
on: el edges: edgs
	"Do the layout of the elements tacking into account the provided edges"

	self userDefinedEdges ifNil: [ self userDefinedEdges: edgs ].

	^ self applyOn: el.
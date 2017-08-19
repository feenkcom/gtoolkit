utils
modOf: aNode
	^ aNode userData at: #mod ifAbsent: [ ^ 0 ]
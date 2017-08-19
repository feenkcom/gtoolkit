building - graph
nodes: aDataCollection
	^ aDataCollection collect: [ :model |
		| child |
		child := self nodeFor: model.
		child userData at: #model put: model.
		child ]
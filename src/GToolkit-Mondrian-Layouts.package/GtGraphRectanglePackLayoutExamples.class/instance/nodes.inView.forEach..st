private
nodes: aDataCollection inView: aView forEach: aBlock
	| nodes |
	nodes := self nodes: aDataCollection.
	nodes do: aBlock.
	aView addChildren: nodes.
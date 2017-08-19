private
rootNodesFor: aCollection
	^ aCollection select: [:node | 
		(self parentsFor: node) isEmpty ].
	
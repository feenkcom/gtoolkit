algorithm
nodeAbcissaWithNeighbor: aNode

	^ aNode x + (horizontalGap / aNode layer /2) + ((self halfDiameterOf: aNode) / aNode layer)
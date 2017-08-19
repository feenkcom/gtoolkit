building - edges
createEdgeIfNecessaryFrom: fromElement to: toElement
	^ (self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ (self edgeFrom: fromElement to: toElement) ]
private - adding / removing
connect: anElement
	"Connect a given element with other elements depending on wether anElement is source or target"

	self
		assert: [ anElement isConnectorSource or: [ anElement isConnectorTarget ] ]
		description: [ 'An element must be either a source or a target' ].

	"Element is a source, connect it to all targets"

	"we assume (?) that source knows target, because we have N:1 (many source - one target)"
	anElement isConnectorSource ifTrue: [
		(self elementsWithTarget: anElement connectorTarget)
			select: [ :aTargetElement | (anElement isConnectedTo: aTargetElement) not
				and: [ (self doesExist: aTargetElement)
					and: [ (self doesExist: anElement) ] ] ]
			thenDo: [ :aTargetElement | self addLineFrom: anElement to: aTargetElement ] ].

	"Element is a target, connect it to all sources"
	anElement isConnectorTarget ifTrue: [
		(self sourcesWithTarget: anElement connectorTarget)
			select: [ :aSourceElement | (aSourceElement isConnectedTo: anElement) not
				and: [ (self doesExist: aSourceElement)
					and: [ (self doesExist: anElement) ] ]  ]
			thenDo: [ :aSourceElement | self addLineFrom: aSourceElement to: anElement ] ]
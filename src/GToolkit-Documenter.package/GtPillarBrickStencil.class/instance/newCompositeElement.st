instance creation
newCompositeElement
	<return: #BlElement>
	^ (BlElement new look: GtPillarCompositeLook new)
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20)
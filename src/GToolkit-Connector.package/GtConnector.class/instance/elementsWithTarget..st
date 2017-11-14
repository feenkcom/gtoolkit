search
elementsWithTarget: aTarget
	"Return a collection of target elements whose target is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorTarget
				and: [ aChildElement connectorTarget = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
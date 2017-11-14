search
sourcesWithTarget: aTarget
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connectorTarget = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
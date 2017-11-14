search
elementsWithSource: aSource
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connectorSource = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
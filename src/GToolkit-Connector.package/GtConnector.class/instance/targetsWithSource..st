search
targetsWithSource: aSource
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorTarget
				and: [ aChildElement connectorSource = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
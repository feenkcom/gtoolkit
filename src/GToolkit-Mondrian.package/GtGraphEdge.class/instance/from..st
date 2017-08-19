private
from: anElement
	from ifNotNil: [ :element | element constraints graph removeConnectedEdge: self ].
	from := anElement.
	anElement constraints graph addConnectedEdge: self
private
to: anElement
	to ifNotNil: [ :element | element constraints graph removeConnectedEdge: self ].
	to := anElement.
	anElement constraints graph addConnectedEdge: self